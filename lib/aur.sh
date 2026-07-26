#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${AUR_LOADED:-}" ]]; then
    return
fi
AUR_LOADED=1

# aur.sh - Library for installing packages from the Arch User Repository (AUR) using Paru.

install_aur_packages() {
    log_info "Installing AUR packages..."

    # Verify that paru is available
    if ! command_exists paru; then
        log_error "AUR helper 'paru' is not installed or not in PATH. Cannot proceed with AUR installation."
        exit 1
    fi

    # Verify AUR_PACKAGES array is defined and populated
    if [[ -z "${AUR_PACKAGES+x}" || ${#AUR_PACKAGES[@]} -eq 0 ]]; then
        log_warning "AUR_PACKAGES array is empty or not loaded. Skipping AUR package installation."
        return 0
    fi

    log_info "The installer will install ${#AUR_PACKAGES[@]} AUR packages..."

    # Install packages using paru.
    # --needed: Do not reinstall up-to-date targets.
    # --noconfirm: Answer yes to all prompt questions.
    if ! paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"; then
        log_error "Failed to install some AUR packages."
        exit 1
    fi

    log_success "All AUR packages have been successfully installed."
}
