#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${RUSTUP_LOADED:-}" ]]; then
    return
fi
RUSTUP_LOADED=1

# rustup.sh - Library for installing Rustup.

install_rustup() {
    log_info "Checking for Rustup..."
    
    if command_exists rustup; then
        log_success "Rustup is already installed."
        return 0
    fi

    log_info "Installing Rustup via official script..."
    
    local rustup_init="/tmp/rustup-init.sh"

    # Download official installer
    if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o "$rustup_init"; then
        log_error "Failed to download Rustup installer."
        exit 1
    fi

    # Run installer non-interactively
    if ! sh "$rustup_init" -y --default-toolchain stable; then
        log_error "Failed to install Rustup."
        rm -f "$rustup_init"
        exit 1
    fi

    rm -f "$rustup_init"

    # Source environment to make rustup available in current shell
    # shellcheck disable=SC1091
    if [[ -f "$HOME/.cargo/env" ]]; then
        source "$HOME/.cargo/env"
    fi

    log_info "Setting default Rust toolchain to stable..."
    rustup default stable

    log_success "Rustup installed and configured successfully."
}
