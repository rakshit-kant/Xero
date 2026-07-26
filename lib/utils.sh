#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${UTILS_LOADED:-}" ]]; then
    return
fi
UTILS_LOADED=1

# utils.sh - Helper functions and utilities for the installer.
# This file is kept dependency-free. It uses terminal color variables
# if they are initialized, but gracefully falls back if they are not.

print_banner() {
    echo "=========================================="
    echo " Arch Linux Hyprland Installer"
    echo "=========================================="
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

log_info() {
    printf "%b[INFO]%b %s\n" "${COLOR_INFO:-}" "${COLOR_RESET:-}" "$1"
}

log_success() {
    printf "%b[SUCCESS]%b %s\n" "${COLOR_SUCCESS:-}" "${COLOR_RESET:-}" "$1"
}

log_warning() {
    printf "%b[WARNING]%b %s\n" "${COLOR_WARNING:-}" "${COLOR_RESET:-}" "$1"
}

log_error() {
    printf "%b[ERROR]%b %s\n" "${COLOR_ERROR:-}" "${COLOR_RESET:-}" "$1" >&2
}

require_command() {
    local cmd="$1"
    if ! command_exists "$cmd"; then
        log_error "Required command '$cmd' is not installed."
        exit 1
    fi
}

create_xdg_directories() {
    log_info "Updating XDG user directories..."
    if command_exists xdg-user-dirs-update; then
        xdg-user-dirs-update
        log_success "XDG user directories updated successfully."
    else
        log_warning "xdg-user-dirs-update command not found. Skipping directory update."
    fi
}

cleanup() {
    log_info "Performing cleanup of temporary installation files..."
    local temp_build_dir="/tmp/paru-build"
    if [[ -d "$temp_build_dir" ]]; then
        log_info "Removing temporary build directory: $temp_build_dir"
        rm -rf "$temp_build_dir"
    fi
    log_success "Cleanup completed."
}

create_wayland_session() {
    log_info "Ensuring Hyprland session file exists for display managers..."

    local session_dir="/usr/share/wayland-sessions"
    local session_file="$session_dir/hyprland.desktop"

    if [[ -f "$session_file" ]]; then
        log_success "Hyprland session file already exists in $session_dir."
        return 0
    fi

    log_info "Creating Hyprland session file in $session_file..."
    
    # Using sudo because /usr/share/wayland-sessions is root-owned
    sudo mkdir -p "$session_dir"
    
    cat <<EOF | sudo tee "$session_file" > /dev/null
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
DesktopNames=Hyprland
EOF

    log_success "Hyprland session file created."
}

print_summary() {
    echo ""
    log_success "Arch Linux Hyprland Setup installation completed successfully!"
    echo "======================================================================"
    log_info "Installed Components:"
    echo "  - Hyprland Window Manager & Waybar Status Bar"
    echo "  - Walker App Launcher & SwayNC Notification Center"
    echo "  - WezTerm Terminal Emulator"
    echo "  - Audio Stack (Pipewire, Wireplumber, Pavucontrol)"
    echo "  - Network & Bluetooth (NetworkManager, Bluez, Blueman)"
    echo "  - Screen Utilities (grim, slurp, swappy, cliphist)"
    echo "  - Essential Development Tools (Base-devel, GCC, Clang, CMake, Ninja, Meson)"
    echo "  - High-performance CLI tools (Neovim, Starship, fastfetch, btop, ripgrep, eza, bat, fzf)"
    echo "  - AUR Helper (Paru)"
    echo "======================================================================"
    log_info "Next Steps:"
    echo "  1. Reboot your system to start all system and user services."
    echo "  2. Log in using a display manager or start Hyprland from the TTY."
    echo "  3. Configure your personalized dotfiles or theme your desktop."
    echo "======================================================================"
}
