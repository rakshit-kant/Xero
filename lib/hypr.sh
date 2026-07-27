#!/usr/bin/env bash

set -euo pipefail

install_hypr_config() {
    log_info "Installing Hyprland configuration..."

    local repo="https://github.com/rakshit-kant/hypr.git"
    local temp_dir="/tmp/hypr-config"
    local target="$HOME/.config/hypr"
    local backup="$HOME/.config_backup/hypr"

    # Check if git exists
    if ! command_exists git; then
        log_error "Git is required to clone Hyprland configuration."
        exit 1
    fi

    # Backup existing config
    if [[ -e "$target" ]]; then
        log_warning "Existing Hyprland config found."

        mkdir -p "$HOME/.config_backup"

        rm -rf "$backup"
        mv "$target" "$backup"

        log_success "Old Hyprland config backed up to ~/.config_backup/nvim"
    fi

    # Clone config repository
    log_info "Cloning Hyprland configuration..."

    rm -rf "$temp_dir"

    if ! git clone "$repo" "$temp_dir"; then
        log_error "Failed to clone Hyprland configuration repository."
        exit 1
    fi

    # Install config
    mkdir -p "$HOME/.config"

    cp -r "$temp_dir" "$target"

    # Remove git files
    rm -rf "$target/.git"

    log_success "Hyprland configuration installed."

    # Cleanup
    rm -rf "$temp_dir"

    log_success "Temporary files cleaned."
}
