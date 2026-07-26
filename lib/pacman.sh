#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${PACMAN_LOADED:-}" ]]; then
    return
fi
PACMAN_LOADED=1

# pacman.sh - Library for synchronizing pacman and installing official Arch Linux packages.

synchronize_pacman() {
    log_info "Synchronizing pacman package databases and performing a full system upgrade..."
    # Performing a full system upgrade (-Syu) is mandatory on Arch Linux 
    # to avoid partial upgrades, which are officially unsupported and can cause instability.
    if ! sudo pacman -Syu --noconfirm; then
        log_error "Failed to synchronize pacman or perform system upgrade."
        exit 1
    fi
    log_success "System synchronized and packages upgraded successfully."
}

install_official_packages() {
    log_info "Installing official packages via pacman..."

    # Ensure the OFFICIAL_PACKAGES array from packages.sh is accessible
    if [[ -z "${OFFICIAL_PACKAGES+x}" || ${#OFFICIAL_PACKAGES[@]} -eq 0 ]]; then
        log_error "OFFICIAL_PACKAGES array is empty or not loaded. Make sure packages.sh is sourced."
        exit 1
    fi

    log_info "The installer will install ${#OFFICIAL_PACKAGES[@]} packages..."
    
    # --needed prevents reinstallation of already up-to-date packages.
    # Installing all packages in a single command is more efficient and handles dependencies better.
    if ! sudo pacman -S --needed --noconfirm "${OFFICIAL_PACKAGES[@]}"; then
        log_error "Failed to install some official packages."
        exit 1
    fi

    log_success "All official packages have been successfully installed."
}
