#!/bin/bash

# AwesomeWM Configuration Dependencies Checker
# Verifies if all required dependencies are installed

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}           ${BLUE}AwesomeWM Configuration Dependencies Checker${NC}        ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
}

check_command() {
    local cmd="$1"
    local description="$2"
    local optional="$3"
    
    if command -v "$cmd" &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} $cmd - $description"
        return 0
    else
        if [ "$optional" = "optional" ]; then
            echo -e "  ${YELLOW}○${NC} $cmd - $description (optional)"
            return 1
        else
            echo -e "  ${RED}✗${NC} $cmd - $description"
            return 1
        fi
    fi
}

check_file() {
    local file="$1"
    local description="$2"
    
    if [ -f "$file" ]; then
        echo -e "  ${GREEN}✓${NC} $description"
        return 0
    else
        echo -e "  ${RED}✗${NC} $description"
        return 1
    fi
}

check_directory() {
    local dir="$1"
    local description="$2"
    
    if [ -d "$dir" ]; then
        echo -e "  ${GREEN}✓${NC} $description"
        return 0
    else
        echo -e "  ${YELLOW}○${NC} $description (will be created)"
        return 1
    fi
}

check_python_module() {
    local module="$1"
    local description="$2"
    local optional="$3"
    
    if python3 -c "import $module" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Python $module - $description"
        return 0
    else
        if [ "$optional" = "optional" ]; then
            echo -e "  ${YELLOW}○${NC} Python $module - $description (optional)"
            return 1
        else
            echo -e "  ${RED}✗${NC} Python $module - $description"
            return 1
        fi
    fi
}

main() {
    print_header
    
    local missing_required=0
    local missing_optional=0
    
    echo -e "${BLUE}Core AwesomeWM Components:${NC}"
    check_command "awesome" "AwesomeWM window manager" || ((missing_required++))
    check_command "lua" "Lua interpreter" || ((missing_required++))
    check_command "Xorg" "X11 server" || ((missing_required++))
    echo
    
    echo -e "${BLUE}Compositor and Visual Effects:${NC}"
    check_command "picom" "Picom compositor" || ((missing_required++))
    check_command "feh" "Wallpaper setter and image viewer" || ((missing_required++))
    echo
    
    echo -e "${BLUE}Applications and Utilities:${NC}"
    check_command "rofi" "Application launcher" || ((missing_required++))
    check_command "gnome-terminal" "Terminal emulator" || ((missing_required++))
    check_command "nautilus" "File manager" || ((missing_required++))
    check_command "google-chrome-stable" "Google Chrome browser" "optional" || ((missing_optional++))
    check_command "firefox" "Firefox browser (fallback)" "optional" || ((missing_optional++))
    echo
    
    echo -e "${BLUE}System Utilities:${NC}"
    check_command "git" "Version control system" || ((missing_required++))
    check_command "curl" "HTTP client" || ((missing_required++))
    check_command "wget" "Download utility" || ((missing_required++))
    check_command "jq" "JSON processor" || ((missing_required++))
    check_command "htop" "System monitor" || ((missing_required++))
    check_command "sensors" "Hardware sensors" "optional" || ((missing_optional++))
    check_command "acpi" "Battery information" "optional" || ((missing_optional++))
    echo
    
    echo -e "${BLUE}Audio System:${NC}"
    check_command "pulseaudio" "Audio server" || ((missing_required++))
    check_command "pactl" "Audio control utility" || ((missing_required++))
    check_command "pavucontrol" "Audio control GUI" "optional" || ((missing_optional++))
    check_command "pasystray" "Audio system tray" "optional" || ((missing_optional++))
    echo
    
    echo -e "${BLUE}Network and Bluetooth:${NC}"
    check_command "nmcli" "Network Manager CLI" || ((missing_required++))
    check_command "nm-applet" "Network Manager applet" "optional" || ((missing_optional++))
    check_command "bluetoothctl" "Bluetooth control" "optional" || ((missing_optional++))
    check_command "blueman-applet" "Bluetooth manager applet" "optional" || ((missing_optional++))
    echo
    
    echo -e "${BLUE}Python and Theme System:${NC}"
    check_command "python3" "Python 3 interpreter" || ((missing_required++))
    check_command "pip3" "Python package manager" "optional" || ((missing_optional++))
    check_python_module "PIL" "Python Imaging Library" || ((missing_required++))
    check_python_module "requests" "HTTP requests library" "optional" || ((missing_optional++))
    check_command "convert" "ImageMagick convert utility" || ((missing_required++))
    echo
    
    echo -e "${BLUE}Development Tools:${NC}"
    check_command "make" "Build utility" "optional" || ((missing_optional++))
    check_command "gcc" "C compiler" "optional" || ((missing_optional++))
    check_command "cmake" "Build system" "optional" || ((missing_optional++))
    check_command "node" "Node.js runtime" "optional" || ((missing_optional++))
    echo
    
    echo -e "${BLUE}Optional Applications:${NC}"
    check_command "slack" "Slack communication" "optional" || ((missing_optional++))
    check_command "code" "Visual Studio Code" "optional" || ((missing_optional++))
    check_command "nvim" "Neovim editor" "optional" || ((missing_optional++))
    check_command "tmux" "Terminal multiplexer" "optional" || ((missing_optional++))
    echo
    
    echo -e "${BLUE}Configuration Directories:${NC}"
    check_directory "$HOME/.config/awesome" "AwesomeWM config directory"
    check_directory "$HOME/.config/picom" "Picom config directory"
    check_directory "$HOME/.local/share/fonts" "User fonts directory"
    check_directory "$HOME/Imagens/wallpapers" "Wallpapers directory"
    echo
    
    echo -e "${BLUE}Font Requirements:${NC}"
    if fc-list | grep -i "jetbrains" | grep -i "nerd" >/dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} JetBrains Mono Nerd Font"
    else
        echo -e "  ${YELLOW}○${NC} JetBrains Mono Nerd Font (recommended)"
        ((missing_optional++))
    fi
    
    if fc-list | grep -i "font.*awesome" >/dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} Font Awesome"
    else
        echo -e "  ${YELLOW}○${NC} Font Awesome (for icons)"
        ((missing_optional++))
    fi
    echo
    
    # Summary
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                          ${BLUE}Summary${NC}                              ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    
    if [ $missing_required -eq 0 ]; then
        echo -e "${GREEN}✓ All required dependencies are installed!${NC}"
    else
        echo -e "${RED}✗ Missing $missing_required required dependencies${NC}"
    fi
    
    if [ $missing_optional -gt 0 ]; then
        echo -e "${YELLOW}○ $missing_optional optional dependencies are missing${NC}"
    else
        echo -e "${GREEN}✓ All optional dependencies are installed!${NC}"
    fi
    
    echo
    
    if [ $missing_required -gt 0 ]; then
        echo -e "${YELLOW}To install missing dependencies, run:${NC}"
        echo -e "  ${BLUE}./install.sh${NC}"
        echo
        return 1
    else
        echo -e "${GREEN}Your system is ready for AwesomeWM with dynamic theme and Picom!${NC}"
        echo
        return 0
    fi
}

main "$@"
