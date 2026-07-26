#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${PARU_LOADED:-}" ]]; then
    return
fi
PARU_LOADED=1

# paru.sh - Library for bootstrapping the Paru AUR helper.

install_paru() {
    log_info "Checking for AUR helper 'paru'..."

    if command_exists paru; then
        log_success "paru is already installed."
        return 0
    fi

    log_info "paru was not found. Bootstrapping 'paru' from AUR..."

    require_command makepkg

    local build_dir="/tmp/paru-build"

    # Clean any stale build files first
    rm -rf "$build_dir"
    mkdir -p "$build_dir"

    log_info "Cloning paru repository..."
    if ! git clone "https://aur.archlinux.org/paru.git" "$build_dir"; then
        log_error "Failed to clone paru from the AUR repository."
        rm -rf "$build_dir"
        exit 1
    fi

    log_info "Building and installing paru..."

    # Execute makepkg inside a subshell to avoid changing the current working directory of the main process.
    # -s: Install missing dependencies via pacman.
    # -i: Install the package built by makepkg.
    # --noconfirm: Skip confirmation prompts.
    if ! (cd "$build_dir" && makepkg -si --noconfirm); then
        log_error "Failed to build and install paru."
        rm -rf "$build_dir"
        exit 1
    fi

    # Clean up build directory
    rm -rf "$build_dir"

    # Double check that paru was successfully installed and is in PATH
    if command_exists paru; then
        log_success "paru has been successfully bootstrapped and installed."
    else
        log_error "paru installation appeared to succeed, but the 'paru' command is still not found in PATH."
        exit 1
    fi
}
