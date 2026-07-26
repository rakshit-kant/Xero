#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${WALLPAPERS_LOADED:-}" ]]; then
    return
fi
WALLPAPERS_LOADED=1

install_wallpapers() {
    log_info "Installing wallpapers..."

    local source="$SCRIPT_DIR/wallpapers"
    local wallpaper_target="$HOME/Pictures/Wallpapers"
    local sddm_theme="/usr/share/sddm/themes/xero"

    if [[ ! -d "$source" ]]; then
        log_warning "No wallpaper directory found. Skipping."
        return 0
    fi

    #
    # Install user wallpapers
    #

    log_info "Installing user wallpapers..."

    mkdir -p "$wallpaper_target"

    for folder in Desktop Lock; do
        if [[ -d "$source/$folder" ]]; then
            rm -rf "$wallpaper_target/$folder"
            cp -r "$source/$folder" "$wallpaper_target/"
            log_success "$folder wallpaper installed."
        fi
    done

    log_success "All wallpapers installed successfully."
}
