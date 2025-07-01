#!/usr/bin/env python3
import sys
import os
from PIL import Image
import colorsys

def rgb_to_hex(rgb):
    return "#{:02x}{:02x}{:02x}".format(int(rgb[0]), int(rgb[1]), int(rgb[2]))

def get_brightness(rgb):
    return (rgb[0] * 0.299 + rgb[1] * 0.587 + rgb[2] * 0.114) / 255

def extract_colors(image_path, num_colors=8):
    try:
        # Open and resize image for faster processing
        img = Image.open(image_path)
        img = img.convert('RGB')
        img = img.resize((150, 150))
        
        # Get most common colors
        colors = img.getcolors(maxcolors=256*256*256)
        if not colors:
            return None
            
        # Sort by frequency and get top colors
        colors.sort(key=lambda x: x[0], reverse=True)
        
        # Extract RGB values
        rgb_colors = []
        for count, color in colors[:num_colors*2]:  # Get more to filter
            rgb_colors.append(color)
        
        # Filter out too similar colors and extreme values
        filtered_colors = []
        for rgb in rgb_colors:
            brightness = get_brightness(rgb)
            # Skip very dark or very light colors
            if 0.1 < brightness < 0.9:
                # Check if color is too similar to existing ones
                is_similar = False
                for existing in filtered_colors:
                    diff = sum(abs(a - b) for a, b in zip(rgb, existing))
                    if diff < 100:  # Threshold for similarity
                        is_similar = True
                        break
                if not is_similar:
                    filtered_colors.append(rgb)
                    if len(filtered_colors) >= num_colors:
                        break
        
        return filtered_colors[:num_colors]
        
    except Exception as e:
        print(f"Error extracting colors: {e}", file=sys.stderr)
        return None

def generate_theme_colors(colors):
    if not colors or len(colors) < 3:
        # Fallback colors
        return {
            'primary': '#48dbfb',
            'secondary': '#feca57', 
            'accent': '#ff6b6b',
            'background': '#1a1a1a',
            'foreground': '#ffffff',
            'background_alt': '#2d2d2d'
        }
    
    # Sort colors by brightness
    colors_with_brightness = [(color, get_brightness(color)) for color in colors]
    colors_with_brightness.sort(key=lambda x: x[1])
    
    # Assign roles based on brightness and saturation
    theme = {}
    
    # Primary: Most saturated mid-brightness color
    primary_candidates = [c for c, b in colors_with_brightness if 0.3 < b < 0.7]
    if primary_candidates:
        # Find most saturated
        primary = max(primary_candidates, key=lambda c: max(c) - min(c))
        theme['primary'] = rgb_to_hex(primary)
    else:
        theme['primary'] = rgb_to_hex(colors[0])
    
    # Secondary: Different hue, similar brightness to primary
    if len(colors) > 1:
        theme['secondary'] = rgb_to_hex(colors[1])
    else:
        theme['secondary'] = '#feca57'
    
    # Accent: Brightest or most contrasting color
    if len(colors) > 2:
        theme['accent'] = rgb_to_hex(colors[2])
    else:
        theme['accent'] = '#ff6b6b'
    
    # Background: Darkest color, made darker
    darkest = min(colors_with_brightness, key=lambda x: x[1])[0]
    bg_color = tuple(max(0, int(c * 0.3)) for c in darkest)  # Make darker
    theme['background'] = rgb_to_hex(bg_color)
    
    # Background alt: Slightly lighter than background
    bg_alt_color = tuple(min(255, int(c * 1.5)) for c in bg_color)
    theme['background_alt'] = rgb_to_hex(bg_alt_color)
    
    # Foreground: Light color or white
    lightest = max(colors_with_brightness, key=lambda x: x[1])[0]
    if get_brightness(lightest) > 0.7:
        theme['foreground'] = rgb_to_hex(lightest)
    else:
        theme['foreground'] = '#ffffff'
    
    return theme

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 extract_colors.py <image_path>")
        sys.exit(1)
    
    image_path = sys.argv[1]
    if not os.path.exists(image_path):
        print(f"Image not found: {image_path}", file=sys.stderr)
        sys.exit(1)
    
    colors = extract_colors(image_path)
    if colors:
        theme = generate_theme_colors(colors)
        
        # Output theme colors in shell-friendly format
        for key, value in theme.items():
            print(f"{key.upper()}='{value}'")
    else:
        print("Failed to extract colors", file=sys.stderr)
        sys.exit(1)
