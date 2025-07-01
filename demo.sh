#!/bin/bash

# AwesomeWM Dynamic Theme & Picom Demo Script
# Demonstrates all the features of the configuration

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_header() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}              ${BLUE}AwesomeWM Configuration Demo${NC}                   ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
}

print_step() {
    echo -e "${BLUE}[DEMO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_info() {
    echo -e "${PURPLE}[INFO]${NC} $1"
}

wait_for_user() {
    echo
    read -p "Press Enter to continue..." -r
    echo
}

demo_widgets() {
    print_step "Demonstrating Widgets in Wibar"
    echo
    print_info "Your wibar should show these 10 widgets:"
    echo -e "  ${GREEN}1.${NC} 📊 CPU Usage"
    echo -e "  ${GREEN}2.${NC} 💾 Memory Usage"
    echo -e "  ${GREEN}3.${NC} 🌐 Network Speed"
    echo -e "  ${GREEN}4.${NC} 🌡️ Temperature"
    echo -e "  ${GREEN}5.${NC} 🔋 Battery Status"
    echo -e "  ${GREEN}6.${NC} 🔊 Volume Control"
    echo -e "  ${GREEN}7.${NC} 🍅 Pomodoro Timer"
    echo -e "  ${GREEN}8.${NC} 🌤️ Weather Info"
    echo -e "  ${GREEN}9.${NC} 🎨 Dynamic Theme"
    echo -e "  ${GREEN}10.${NC} 🎭 Picom Compositor"
    echo
    print_info "All widgets are interactive - try clicking on them!"
    wait_for_user
}

demo_keybindings() {
    print_step "Demonstrating Key Bindings"
    echo
    print_info "Basic AwesomeWM (preserved):"
    echo -e "  ${YELLOW}Super + Return${NC}     → Terminal"
    echo -e "  ${YELLOW}Super + d${NC}          → Rofi launcher"
    echo -e "  ${YELLOW}Super + w${NC}          → Main menu"
    echo -e "  ${YELLOW}Super + s${NC}          → Show all keybindings"
    echo
    print_info "Advanced Features (Alt + letters):"
    echo -e "  ${YELLOW}Alt + p${NC}            → Pomodoro timer"
    echo -e "  ${YELLOW}Alt + w${NC}            → Weather details"
    echo -e "  ${YELLOW}Alt + n${NC}            → Notification center"
    echo -e "  ${YELLOW}Alt + t${NC}            → Dynamic theme toggle"
    echo -e "  ${YELLOW}Alt + c${NC}            → Picom compositor toggle"
    echo
    print_info "Scratchpads (Alt + numbers):"
    echo -e "  ${YELLOW}Alt + 1${NC}            → Terminal dropdown"
    echo -e "  ${YELLOW}Alt + 2${NC}            → Calculator"
    echo -e "  ${YELLOW}Alt + 3${NC}            → Notes (nvim)"
    wait_for_user
}

demo_theme_system() {
    print_step "Demonstrating Dynamic Theme System"
    echo
    print_info "The dynamic theme system:"
    echo -e "  ${GREEN}•${NC} Extracts colors from your wallpaper automatically"
    echo -e "  ${GREEN}•${NC} Applies colors to widgets, borders, and UI elements"
    echo -e "  ${GREEN}•${NC} Switches between day/night variants (6AM-6PM = day)"
    echo -e "  ${GREEN}•${NC} Updates when wallpaper changes"
    echo
    print_info "Try these commands:"
    echo -e "  ${CYAN}Alt + t${NC}            → Toggle dynamic theme"
    echo -e "  ${CYAN}Alt + Shift + t${NC}    → Regenerate theme from wallpaper"
    echo -e "  ${CYAN}Super + Alt + w${NC}    → Restore samurai yellow wallpaper"
    wait_for_user
}

demo_picom() {
    print_step "Demonstrating Picom Visual Effects"
    echo
    print_info "Picom compositor provides:"
    echo -e "  ${GREEN}•${NC} Window shadows (soft and realistic)"
    echo -e "  ${GREEN}•${NC} Transparency effects (inactive windows)"
    echo -e "  ${GREEN}•${NC} Background blur (semi-transparent windows)"
    echo -e "  ${GREEN}•${NC} Rounded corners (8px radius)"
    echo -e "  ${GREEN}•${NC} Smooth animations (fade in/out)"
    echo
    print_info "Controls:"
    echo -e "  ${CYAN}Alt + c${NC}            → Toggle compositor on/off"
    echo -e "  ${CYAN}Alt + Shift + c${NC}    → Performance mode (disable effects)"
    echo -e "  ${CYAN}Alt + Ctrl + c${NC}     → Show compositor status"
    echo
    print_info "Click the 🎭 widget in wibar for more options!"
    wait_for_user
}

demo_scratchpads() {
    print_step "Demonstrating Scratchpads"
    echo
    print_info "Scratchpads are floating windows for quick access:"
    echo
    print_info "Try these now:"
    echo -e "  ${CYAN}Alt + 1${NC} → Terminal dropdown (Quake-style)"
    echo -e "  ${CYAN}Alt + 2${NC} → Calculator (floating)"
    echo -e "  ${CYAN}Alt + 3${NC} → Notes with nvim"
    echo
    print_info "Press the same key again to hide the scratchpad!"
    wait_for_user
}

demo_productivity() {
    print_step "Demonstrating Productivity Features"
    echo
    print_info "Pomodoro Timer:"
    echo -e "  ${CYAN}Alt + p${NC}            → Start/pause 25-minute timer"
    echo -e "  ${CYAN}Alt + Shift + p${NC}    → Show current status"
    echo -e "  ${CYAN}Alt + Ctrl + p${NC}     → Skip current phase"
    echo
    print_info "Weather Widget:"
    echo -e "  ${CYAN}Alt + w${NC}            → Show detailed weather"
    echo -e "  ${CYAN}Alt + Shift + w${NC}    → Refresh weather data"
    echo
    print_info "Notification Center:"
    echo -e "  ${CYAN}Alt + n${NC}            → Toggle notification history"
    echo -e "  ${CYAN}Alt + Shift + n${NC}    → Clear all notifications"
    wait_for_user
}

demo_scripts() {
    print_step "Demonstrating Management Scripts"
    echo
    print_info "Available management scripts:"
    echo
    echo -e "${YELLOW}Theme Management:${NC}"
    echo -e "  ${CYAN}./bin/theme_manager generate${NC}    → Generate theme from wallpaper"
    echo -e "  ${CYAN}./bin/theme_manager info${NC}        → Show theme information"
    echo
    echo -e "${YELLOW}Picom Management:${NC}"
    echo -e "  ${CYAN}./bin/picom_manager start${NC}       → Start compositor"
    echo -e "  ${CYAN}./bin/picom_manager status${NC}      → Show compositor status"
    echo -e "  ${CYAN}./bin/picom_manager performance${NC} → Toggle performance mode"
    echo
    echo -e "${YELLOW}Wallpaper Management:${NC}"
    echo -e "  ${CYAN}./bin/set_default_wallpaper${NC}     → Restore samurai yellow"
    echo
    echo -e "${YELLOW}System Check:${NC}"
    echo -e "  ${CYAN}./check-deps.sh${NC}                 → Check all dependencies"
    wait_for_user
}

show_final_tips() {
    print_step "Final Tips and Tricks"
    echo
    print_info "Pro Tips:"
    echo -e "  ${GREEN}•${NC} Use ${YELLOW}Super + s${NC} to see ALL available keybindings"
    echo -e "  ${GREEN}•${NC} Right-click widgets for context menus"
    echo -e "  ${GREEN}•${NC} The theme updates automatically when you change wallpapers"
    echo -e "  ${GREEN}•${NC} Picom effects adjust based on day/night automatically"
    echo -e "  ${GREEN}•${NC} All scripts have ${YELLOW}--help${NC} or ${YELLOW}help${NC} options"
    echo
    print_info "Customization:"
    echo -e "  ${GREEN}•${NC} Edit ${CYAN}config/variables.lua${NC} for basic settings"
    echo -e "  ${GREEN}•${NC} Modify ${CYAN}config/keys/global.lua${NC} for keybindings"
    echo -e "  ${GREEN}•${NC} Customize ${CYAN}config/ui/widgets/${NC} for widget behavior"
    echo -e "  ${GREEN}•${NC} Adjust ${CYAN}.config/picom/picom.conf${NC} for visual effects"
    echo
    print_info "Troubleshooting:"
    echo -e "  ${GREEN}•${NC} Check ${CYAN}awesome -k${NC} for configuration errors"
    echo -e "  ${GREEN}•${NC} View logs in ${CYAN}~/.config/awesome/*.log${NC}"
    echo -e "  ${GREEN}•${NC} Use ${CYAN}./check-deps.sh${NC} to verify dependencies"
    wait_for_user
}

main() {
    print_header
    
    print_info "Welcome to the AwesomeWM Dynamic Theme & Picom Demo!"
    print_info "This will guide you through all the features of your configuration."
    echo
    print_info "Make sure AwesomeWM is running before proceeding."
    wait_for_user
    
    demo_widgets
    demo_keybindings
    demo_theme_system
    demo_picom
    demo_scratchpads
    demo_productivity
    demo_scripts
    show_final_tips
    
    print_header
    print_success "Demo completed!"
    echo
    print_info "Your AwesomeWM configuration includes:"
    echo -e "  ${GREEN}✓${NC} 10 functional widgets"
    echo -e "  ${GREEN}✓${NC} Dynamic theme system"
    echo -e "  ${GREEN}✓${NC} Picom visual effects"
    echo -e "  ${GREEN}✓${NC} 3 scratchpads"
    echo -e "  ${GREEN}✓${NC} Productivity features"
    echo -e "  ${GREEN}✓${NC} Management scripts"
    echo -e "  ${GREEN}✓${NC} Organized keybindings"
    echo
    print_success "Enjoy your modern AwesomeWM setup! 🚀"
}

main "$@"
