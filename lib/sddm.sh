#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${SDDM_LOADED:-}" ]]; then
    return
fi
SDDM_LOADED=1

install_sddm() {
    log_info "Installing SDDM configuration..."

    local source="$SCRIPT_DIR/sddm"
    local theme_source="$source/xero"
    local theme_target="/usr/share/sddm/themes/xero"
    local config_target="/etc/sddm.conf.d"

    if [[ ! -d "$theme_source" ]]; then
        log_warning "Xero SDDM theme not found. Skipping."
        return 0
    fi

    #
    # Install Xero SDDM Theme
    #

    log_info "Installing Xero SDDM theme..."

    sudo mkdir -p "$theme_target"

    sudo cp -r "$theme_source/"* "$theme_target/"

    log_success "Xero SDDM theme installed."

    #
    # Install SDDM Wallpaper
    #

    log_info "Installing SDDM wallpaper..."

    if [[ -f "$theme_source/xero-login.png" ]]; then
        sudo cp "$theme_source/xero-login.png" \
            "$theme_target/xero-login.png"

        log_success "SDDM wallpaper installed."
    else
        log_warning "xero-login.png not found. Skipping."
    fi

    #
    # Create Theme Configuration
    #

    log_info "Creating Xero theme configuration..."

    sudo tee "$theme_target/theme.conf" >/dev/null <<EOF
[General]
background=xero-login.png
EOF

    #
    # Configure SDDM
    #

    log_info "Configuring SDDM..."

    sudo mkdir -p "$config_target"

    sudo tee "$config_target/theme.conf" >/dev/null <<EOF
[Theme]
Current=xero
EOF

    sudo tee "$config_target/general.conf" >/dev/null <<EOF
[General]
Numlock=on
EOF

    sudo tee "$config_target/wayland.conf" >/dev/null <<EOF
[Wayland]
EnableHiDPI=true
EOF

    log_success "SDDM configured successfully."
}

enable_sddm() {
    log_info "Enabling SDDM service..."

    sudo systemctl enable sddm.service

    log_success "SDDM enabled."
}

setup_sddm() {
    install_sddm
    enable_sddm
}
