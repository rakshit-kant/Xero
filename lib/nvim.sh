#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${NVIM_LOADED:-}" ]]; then
    return
fi
NVIM_LOADED=1

install_nvim_config() {
    log_info "Installing Neovim configuration..."

    local repo="https://github.com/rakshit-kant/nvim.git"
    local temp_dir="/tmp/nvim-config"
    local target="$HOME/.config/nvim"
    local backup="$HOME/.config_backup/nvim"

    # Check if git exists
    if ! command_exists git; then
        log_error "Git is required to clone Neovim configuration."
        exit 1
    fi

    # Backup existing config
    if [[ -e "$target" ]]; then
        log_warning "Existing Neovim config found."

        mkdir -p "$HOME/.config_backup"

        rm -rf "$backup"
        mv "$target" "$backup"

        log_success "Old Neovim config backed up to ~/.config_backup/nvim"
    fi

    # Clone config repository
    log_info "Cloning Neovim configuration..."

    rm -rf "$temp_dir"

    if ! git clone "$repo" "$temp_dir"; then
        log_error "Failed to clone Neovim configuration repository."
        exit 1
    fi

    # Install config
    mkdir -p "$HOME/.config"

    cp -r "$temp_dir" "$target"

    # Remove git files
    rm -rf "$target/.git"

    log_success "Neovim configuration installed."

    # Cleanup
    rm -rf "$temp_dir"

    log_success "Temporary files cleaned."
}
