#!/bin/bash

# AwesomeWM Dynamic Theme & Picom Setup Installer
# Installs all prerequisites and dependencies for the complete configuration
# Compatible with Ubuntu/Debian-based systems

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
AWESOME_CONFIG_DIR="$HOME/.config/awesome"
LOG_FILE="$AWESOME_CONFIG_DIR/install.log"
BACKUP_DIR="$HOME/.config/awesome-backup-$(date +%Y%m%d-%H%M%S)"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Print functions
print_header() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}  ${BLUE}AwesomeWM Dynamic Theme & Picom Setup Installer${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
    log "STEP: $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
    log "SUCCESS: $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
    log "WARNING: $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    log "ERROR: $1"
}

print_info() {
    echo -e "${PURPLE}[INFO]${NC} $1"
    log "INFO: $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root!"
        print_info "Please run as your regular user. The script will ask for sudo when needed."
        exit 1
    fi
}

# Check system compatibility
check_system() {
    print_step "Checking system compatibility..."
    
    if ! command -v apt &> /dev/null; then
        print_error "This installer is designed for Ubuntu/Debian-based systems"
        print_info "Please install dependencies manually on your system"
        exit 1
    fi
    
    # Check Ubuntu/Debian version
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        print_success "Detected: $PRETTY_NAME"
    else
        print_warning "Could not detect OS version, proceeding anyway..."
    fi
}

# Create backup of existing configuration
backup_existing_config() {
    if [ -d "$AWESOME_CONFIG_DIR" ]; then
        print_step "Backing up existing AwesomeWM configuration..."
        
        if cp -r "$AWESOME_CONFIG_DIR" "$BACKUP_DIR" 2>/dev/null; then
            print_success "Backup created at: $BACKUP_DIR"
        else
            print_warning "Could not create backup, but continuing..."
        fi
    else
        print_info "No existing AwesomeWM configuration found"
    fi
}

# Update package lists
update_packages() {
    print_step "Updating package lists..."
    
    if sudo apt update; then
        print_success "Package lists updated"
    else
        print_error "Failed to update package lists"
        exit 1
    fi
}

# Install core AwesomeWM and dependencies
install_awesome_core() {
    print_step "Installing AwesomeWM and core dependencies..."
    
    local packages=(
        "awesome"                    # AwesomeWM window manager
        "awesome-extra"              # Extra AwesomeWM utilities
        "xorg"                       # X11 server
        "xinit"                      # X11 initialization
        "lightdm"                    # Display manager
        "lightdm-gtk-greeter"        # LightDM greeter
    )
    
    if sudo apt install -y "${packages[@]}"; then
        print_success "AwesomeWM core installed"
    else
        print_error "Failed to install AwesomeWM core"
        exit 1
    fi
}

# Install applications
install_applications() {
    print_step "Installing essential applications..."
    
    local packages=(
        # Terminal and shell
        "gnome-terminal"             # Terminal emulator
        "zsh"                        # Z shell
        "curl"                       # HTTP client
        "wget"                       # Download utility
        "git"                        # Version control
        
        # File management
        "nautilus"                   # File manager
        "file-roller"                # Archive manager
        "tree"                       # Directory tree viewer
        
        # System utilities
        "htop"                       # System monitor
        "neofetch"                   # System info
        "lm-sensors"                 # Hardware sensors
        "acpi"                       # Battery info
        "brightnessctl"              # Brightness control
        
        # Audio
        "pulseaudio"                 # Audio server
        "pavucontrol"                # Audio control
        "pasystray"                  # Audio system tray
        "alsa-utils"                 # Audio utilities
        
        # Network
        "network-manager"            # Network management
        "network-manager-gnome"      # Network manager GUI
        
        # Bluetooth
        "bluez"                      # Bluetooth stack
        "blueman"                    # Bluetooth manager
        
        # Fonts
        "fonts-noto"                 # Noto fonts
        "fonts-noto-color-emoji"     # Emoji fonts
        "fonts-font-awesome"         # Font Awesome icons
    )
    
    if sudo apt install -y "${packages[@]}"; then
        print_success "Essential applications installed"
    else
        print_warning "Some applications failed to install, continuing..."
    fi
}

# Install development tools
install_dev_tools() {
    print_step "Installing development tools..."
    
    local packages=(
        "build-essential"            # Build tools
        "cmake"                      # Build system
        "pkg-config"                 # Package config
        "lua5.3"                     # Lua interpreter
        "luarocks"                   # Lua package manager
        "python3"                    # Python 3
        "python3-pip"                # Python package manager
        "nodejs"                     # Node.js
        "npm"                        # Node package manager
        "jq"                         # JSON processor
    )
    
    if sudo apt install -y "${packages[@]}"; then
        print_success "Development tools installed"
    else
        print_warning "Some development tools failed to install, continuing..."
    fi
}

# Create Picom configuration file
create_picom_config() {
    local picom_config_dir="$HOME/.config/picom"
    local picom_config_file="$picom_config_dir/picom.conf"
    
    print_step "Creating Picom configuration at $picom_config_file"
    
    # Ensure directory exists
    mkdir -p "$picom_config_dir"
    
    # Create picom.conf
    cat > "$picom_config_file" << 'EOF'
# Picom Configuration for AwesomeWM
# Optimized for dynamic theme integration and visual effects

# Backend
backend = "glx";
glx-no-stencil = true;
glx-copy-from-front = false;
glx-no-rebind-pixmap = true;

# Shadows
shadow = true;
shadow-radius = 12;
shadow-offset-x = -15;
shadow-offset-y = -15;
shadow-opacity = 0.75;

# Exclude shadows for some windows
shadow-exclude = [
    "name = 'Notification'",
    "class_g = 'Conky'",
    "class_g ?= 'Notify-osd'",
    "class_g = 'Cairo-clock'",
    "class_g = 'awesome'",
    "_GTK_FRAME_EXTENTS@:c",
    "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
];

# Opacity
inactive-opacity = 0.9;
active-opacity = 1.0;
frame-opacity = 1.0;
inactive-opacity-override = false;

# Opacity rules - optimized for AwesomeWM
opacity-rule = [
    "100:class_g = 'firefox'",
    "100:class_g = 'Firefox'",
    "100:class_g = 'Google-chrome'",
    "100:class_g = 'google-chrome'",
    "95:class_g = 'Gnome-terminal'",
    "95:class_g = 'gnome-terminal-server'",
    "90:class_g = 'Rofi'",
    "95:class_g = 'Code'",
    "95:class_g = 'code'",
    "90:class_g = 'Slack'",
    "95:class_g = 'Nautilus'",
    "100:class_g = 'awesome'"
];

# Blur
blur-background = true;
blur-background-frame = true;
blur-method = "dual_kawase";
blur-strength = 5;

# Blur exclude
blur-background-exclude = [
    "window_type = 'dock'",
    "window_type = 'desktop'",
    "class_g = 'awesome'",
    "_GTK_FRAME_EXTENTS@:c"
];

# Fading
fading = true;
fade-delta = 4;
fade-in-step = 0.03;
fade-out-step = 0.03;

# Exclude fading for some windows
fade-exclude = [
    "class_g = 'awesome'"
];

# Rounded corners
corner-radius = 8;
rounded-corners-exclude = [
    "window_type = 'dock'",
    "window_type = 'desktop'",
    "class_g = 'awesome'"
];

# Window type settings
wintypes: {
    tooltip = { fade = true; shadow = true; opacity = 0.85; focus = true; full-shadow = false; };
    dock = { shadow = false; clip-shadow-above = true; };
    dnd = { shadow = false; };
    popup_menu = { opacity = 0.95; };
    dropdown_menu = { opacity = 0.95; };
    above = { shadow = true; };
    splash = { shadow = false; };
    utility = { focus = true; shadow = false; blur-background = false; };
    notification = { shadow = false; };
    desktop = { shadow = false; blur-background = false; };
    menu = { focus = false; };
    dialog = { shadow = true; };
};

# Performance optimizations
vsync = true;
mark-wmwin-focused = true;
mark-ovredir-focused = true;
detect-rounded-corners = true;
detect-client-opacity = true;
refresh-rate = 0;
detect-transient = true;
detect-client-leader = true;
use-damage = true;

# Experimental features (comment out if causing issues)
experimental-backends = true;
EOF

    if [[ -f "$picom_config_file" ]]; then
        print_success "Picom configuration created successfully"
        log "SUCCESS: Picom config created at $picom_config_file"
    else
        print_error "Failed to create Picom configuration"
        log "ERROR: Failed to create Picom config"
        exit 1
    fi
}

# Install Picom compositor
install_picom() {
    print_step "Installing Picom compositor..."
    
    if sudo apt install -y picom; then
        print_success "Picom compositor installed"
        
        # Create Picom configuration
        print_step "Creating Picom configuration..."
        create_picom_config
        
    else
        print_error "Failed to install Picom"
        exit 1
    fi
}

# Install Python dependencies for theme system
install_python_deps() {
    print_step "Installing Python dependencies for dynamic theme..."
    
    local packages=(
        "python3-pil"                # Python Imaging Library
        "python3-requests"           # HTTP requests
        "python3-json5"              # JSON5 parser
        "imagemagick"                # Image manipulation
    )
    
    if sudo apt install -y "${packages[@]}"; then
        print_success "Python dependencies installed"
    else
        print_warning "Some Python dependencies failed to install"
    fi
    
    # Try to install additional Python packages via pip
    print_info "Installing additional Python packages..."
    if python3 -m pip install --user colorthief 2>/dev/null; then
        print_success "ColorThief installed via pip"
    else
        print_warning "ColorThief installation failed, using fallback method"
    fi
}

# Install Rofi launcher
install_rofi() {
    print_step "Installing Rofi application launcher..."
    
    if sudo apt install -y rofi; then
        print_success "Rofi launcher installed"
    else
        print_warning "Rofi installation failed"
    fi
}

# Install additional utilities
install_utilities() {
    print_step "Installing additional utilities..."
    
    local packages=(
        "feh"                        # Image viewer and wallpaper setter
        "scrot"                      # Screenshot utility
        "xclip"                      # Clipboard utility
        "redshift"                   # Blue light filter
        "unzip"                      # Archive utility
        "zip"                        # Archive utility
        "rsync"                      # File synchronization
        "tmux"                       # Terminal multiplexer
        "vim"                        # Text editor
        "nano"                       # Simple text editor
        "firefox"                    # Web browser (fallback)
    )
    
    if sudo apt install -y "${packages[@]}"; then
        print_success "Additional utilities installed"
    else
        print_warning "Some utilities failed to install, continuing..."
    fi
}

# Install Google Chrome
install_chrome() {
    print_step "Installing Google Chrome..."
    
    # Check if Chrome is already installed
    if command -v google-chrome-stable &> /dev/null; then
        print_success "Google Chrome already installed"
        return 0
    fi
    
    # Download and install Chrome
    local chrome_deb="/tmp/google-chrome-stable_current_amd64.deb"
    
    if wget -q -O "$chrome_deb" "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"; then
        if sudo dpkg -i "$chrome_deb" 2>/dev/null || sudo apt-get install -f -y; then
            print_success "Google Chrome installed"
            rm -f "$chrome_deb"
        else
            print_warning "Google Chrome installation failed"
        fi
    else
        print_warning "Could not download Google Chrome"
    fi
}

# Install JetBrains Mono Nerd Font
install_nerd_fonts() {
    print_step "Installing JetBrains Mono Nerd Font..."
    
    local font_dir="$HOME/.local/share/fonts"
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
    local font_zip="/tmp/JetBrainsMono.zip"
    
    mkdir -p "$font_dir"
    
    if wget -q -O "$font_zip" "$font_url"; then
        if unzip -q "$font_zip" -d "$font_dir/JetBrainsMono" 2>/dev/null; then
            # Update font cache
            fc-cache -fv "$font_dir" >/dev/null 2>&1
            print_success "JetBrains Mono Nerd Font installed"
            rm -f "$font_zip"
        else
            print_warning "Font extraction failed"
        fi
    else
        print_warning "Could not download JetBrains Mono Nerd Font"
    fi
}

# Install Slack (optional)
install_slack() {
    print_step "Installing Slack (optional)..."
    
    # Check if user wants Slack
    read -p "Do you want to install Slack? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v snap &> /dev/null; then
            if sudo snap install slack --classic; then
                print_success "Slack installed via Snap"
            else
                print_warning "Slack installation via Snap failed"
            fi
        else
            print_info "Snap not available, skipping Slack installation"
        fi
    else
        print_info "Skipping Slack installation"
    fi
}

# Install VSCode (optional)
install_vscode() {
    print_step "Installing Visual Studio Code (optional)..."
    
    # Check if user wants VSCode
    read -p "Do you want to install Visual Studio Code? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Add Microsoft GPG key and repository
        if wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg; then
            sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
            sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
            
            if sudo apt update && sudo apt install -y code; then
                print_success "Visual Studio Code installed"
            else
                print_warning "VSCode installation failed"
            fi
            
            rm -f packages.microsoft.gpg
        else
            print_warning "Could not add Microsoft repository"
        fi
    else
        print_info "Skipping VSCode installation"
    fi
}

# Create necessary directories
create_directories() {
    print_step "Creating necessary directories..."
    
    local directories=(
        "$HOME/.config/awesome"
        "$HOME/.config/picom"
        "$HOME/.local/share/fonts"
        "$HOME/.local/share/backgrounds"
        "$HOME/Imagens/wallpapers"
        "$HOME/.cache/awesome"
    )
    
    for dir in "${directories[@]}"; do
        if mkdir -p "$dir"; then
            print_info "Created directory: $dir"
        else
            print_warning "Could not create directory: $dir"
        fi
    done
    
    print_success "Directories created"
}

# Set up services
setup_services() {
    print_step "Setting up system services..."
    
    # Enable NetworkManager
    if sudo systemctl enable NetworkManager 2>/dev/null; then
        print_success "NetworkManager enabled"
    else
        print_warning "Could not enable NetworkManager"
    fi
    
    # Enable Bluetooth
    if sudo systemctl enable bluetooth 2>/dev/null; then
        print_success "Bluetooth service enabled"
    else
        print_warning "Could not enable Bluetooth"
    fi
    
    # Enable LightDM
    if sudo systemctl enable lightdm 2>/dev/null; then
        print_success "LightDM display manager enabled"
    else
        print_warning "Could not enable LightDM"
    fi
}

# Configure LightDM for AwesomeWM
configure_lightdm() {
    print_step "Configuring LightDM for AwesomeWM..."
    
    # Create AwesomeWM desktop entry if it doesn't exist
    local awesome_desktop="/usr/share/xsessions/awesome.desktop"
    
    if [ ! -f "$awesome_desktop" ]; then
        sudo tee "$awesome_desktop" > /dev/null << EOF
[Desktop Entry]
Name=awesome
Comment=Highly configurable framework window manager
TryExec=awesome
Exec=awesome
Type=Application
X-LightDM-DesktopName=awesome
DesktopNames=awesome
Keywords=Window manager
EOF
        print_success "AwesomeWM desktop entry created"
    else
        print_info "AwesomeWM desktop entry already exists"
    fi
}

# Final system configuration
final_configuration() {
    print_step "Performing final system configuration..."
    
    # Add user to audio group
    if sudo usermod -a -G audio "$USER" 2>/dev/null; then
        print_success "User added to audio group"
    else
        print_warning "Could not add user to audio group"
    fi
    
    # Set up sensors
    if sudo sensors-detect --auto 2>/dev/null; then
        print_success "Hardware sensors configured"
    else
        print_warning "Could not configure hardware sensors"
    fi
    
    # Update font cache
    if fc-cache -fv >/dev/null 2>&1; then
        print_success "Font cache updated"
    else
        print_warning "Could not update font cache"
    fi
}

# Check installation
check_installation() {
    print_step "Verifying installation..."
    
    local required_commands=(
        "awesome"
        "picom"
        "rofi"
        "feh"
        "python3"
        "git"
        "curl"
    )
    
    local missing_commands=()
    
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_commands+=("$cmd")
        fi
    done
    
    if [ ${#missing_commands[@]} -eq 0 ]; then
        print_success "All required commands are available"
        return 0
    else
        print_warning "Missing commands: ${missing_commands[*]}"
        return 1
    fi
}

# Initialize Picom after installation
initialize_picom() {
    print_step "Initializing Picom compositor..."
    
    # Check if we're in a graphical session
    if [[ -n "$DISPLAY" ]] && command -v picom >/dev/null 2>&1; then
        # Try to start Picom using the manager script
        if [[ -x "$AWESOME_CONFIG_DIR/bin/picom_manager" ]]; then
            if "$AWESOME_CONFIG_DIR/bin/picom_manager" start >/dev/null 2>&1; then
                print_success "Picom compositor started successfully"
                log "SUCCESS: Picom initialized"
            else
                print_warning "Picom installation complete, but couldn't start automatically"
                print_info "You can start it manually with: Alt + c (after logging into AwesomeWM)"
                log "WARNING: Picom auto-start failed"
            fi
        else
            print_warning "Picom manager script not found, skipping auto-start"
            log "WARNING: Picom manager not found"
        fi
    else
        print_info "Picom will start automatically when you log into AwesomeWM"
        log "INFO: Picom setup complete, will start with AwesomeWM"
    fi
}

# Show post-installation instructions
show_post_install() {
    echo
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                    ${GREEN}Installation Complete!${NC}                     ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
    
    print_info "Next steps:"
    echo -e "  ${BLUE}1.${NC} Logout and select 'awesome' from the login screen"
    echo -e "  ${BLUE}2.${NC} Your AwesomeWM configuration should be ready to use"
    echo -e "  ${BLUE}3.${NC} Press ${YELLOW}Super + s${NC} to see all available keybindings"
    echo -e "  ${BLUE}4.${NC} The dynamic theme and Picom should start automatically"
    echo
    
    print_info "Key features available:"
    echo -e "  ${PURPLE}•${NC} Dynamic theme based on wallpaper"
    echo -e "  ${PURPLE}•${NC} Picom compositor with visual effects (auto-configured)"
    echo -e "  ${PURPLE}•${NC} 10 functional widgets in the status bar"
    echo -e "  ${PURPLE}•${NC} Scratchpads for quick access (Alt + 1/2/3)"
    echo -e "  ${PURPLE}•${NC} Pomodoro timer (Alt + p)"
    echo -e "  ${PURPLE}•${NC} Weather widget (Alt + w)"
    echo -e "  ${PURPLE}•${NC} Notification center (Alt + n)"
    echo
    
    print_info "Configuration files created:"
    echo -e "  ${PURPLE}•${NC} AwesomeWM config: ${YELLOW}~/.config/awesome/${NC}"
    echo -e "  ${PURPLE}•${NC} Picom config: ${YELLOW}~/.config/picom/picom.conf${NC}"
    echo -e "  ${PURPLE}•${NC} Theme system: ${YELLOW}~/.config/awesome/themes/${NC}"
    echo
    
    if [ -d "$BACKUP_DIR" ]; then
        print_info "Your previous configuration was backed up to:"
        echo -e "  ${YELLOW}$BACKUP_DIR${NC}"
    fi
    
    print_info "Installation log saved to:"
    echo -e "  ${YELLOW}$LOG_FILE${NC}"
    echo
    
    print_success "Enjoy your new AwesomeWM setup! 🚀"
}

# Main installation function
main() {
    # Create log file
    mkdir -p "$(dirname "$LOG_FILE")"
    touch "$LOG_FILE"
    
    print_header
    
    # Pre-installation checks
    check_root
    check_system
    backup_existing_config
    
    # Core installation
    update_packages
    install_awesome_core
    install_applications
    install_dev_tools
    install_picom
    install_python_deps
    install_rofi
    install_utilities
    
    # Optional installations
    install_chrome
    install_nerd_fonts
    install_slack
    install_vscode
    
    # Configuration
    create_directories
    setup_services
    configure_lightdm
    final_configuration
    
    # Initialize services
    initialize_picom
    
    # Verification
    if check_installation; then
        show_post_install
    else
        print_error "Installation completed with some issues"
        print_info "Check the log file for details: $LOG_FILE"
        exit 1
    fi
}

# Run main function
main "$@"
