#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${RUSTUP_LOADED:-}" ]]; then
    return
fi
RUSTUP_LOADED=1

# rustup.sh - Library for installing Rustup and Rust development tools.

install_rustup() {
    log_info "Checking for Rustup..."

    if command_exists rustup; then
        log_success "Rustup is already installed."
    else
        log_info "Installing Rustup via official script..."

        local rustup_init="/tmp/rustup-init.sh"

        if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o "$rustup_init"; then
            log_error "Failed to download Rustup installer."
            exit 1
        fi

        if ! sh "$rustup_init" -y --default-toolchain stable; then
            log_error "Failed to install Rustup."
            rm -f "$rustup_init"
            exit 1
        fi

        rm -f "$rustup_init"

        if [[ -f "$HOME/.cargo/env" ]]; then
            # shellcheck disable=SC1091
            source "$HOME/.cargo/env"
        fi

        log_success "Rustup installed successfully."
    fi

    log_info "Setting Rust stable toolchain..."
    rustup default stable

    install_rust_tools

    log_success "Rust environment configured successfully."
}

install_rust_tools() {
    log_info "Installing Rust development components..."

    local components=(
        rustfmt
        clippy
        rust-analyzer
        rust-docs
        llvm-tools-preview
    )

    for component in "${components[@]}"; do
        log_info "Installing component: $component"

        if ! rustup component add "$component"; then
            log_error "Failed to install Rust component: $component"
            exit 1
        fi
    done

    log_success "Rust development components installed."
}
