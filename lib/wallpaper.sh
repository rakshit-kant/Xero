#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${WALLPAPERS_LOADED:-}" ]]; then
    return
fi
WALLPAPERS_LOADED=1

install_wallpapers() {
    log_info "Installing wallpapers..."

    local source="$SCRIPT_DIR/wallpapers"
    local target="$HOME/Pictures/Wallpapers"

    if [[ ! -d "$source" ]]; then
        log_warning "No wallpaper directory found. Skipping."
        return 0
    fi

    mkdir -p "$target"

    cp -r "$source/"* "$target/"

    log_success "Wallpapers installed to ~/Pictures/Wallpapers"
}
