#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${NVIM_LOADED:-}" ]]; then
    return
fi
NVIM_LOADED=1

install_nvim_config() {
    log_info "Installing Neovim configuration..."

    local source="$SCRIPT_DIR/config/nvim"
    local target="$HOME/.config/nvim"
    local backup="$HOME/.config_backup/nvim"

    if [[ ! -d "$source" ]]; then
        log_error "Neovim config not found in installer/config/nvim"
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

    # Install new config
    mkdir -p "$HOME/.config"

    cp -r "$source" "$target"

    log_success "Neovim configuration installed."
}
