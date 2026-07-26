#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${CHECKS_LOADED:-}" ]]; then
    return
fi
CHECKS_LOADED=1

# checks.sh - Environment and pre-requisite checks.
# Ensures the installer runs under the correct conditions (Arch Linux, non-root, internet active).

SUDO_KEEPALIVE_PID=""

start_sudo_keepalive() {
    while true; do
        sudo -n true
        sleep 60
    done &
    
    SUDO_KEEPALIVE_PID=$!
}

cleanup_sudo_keepalive() {
    if [[ -n "${SUDO_KEEPALIVE_PID}" ]]; then
        kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
    fi
}

check_arch() {
    log_info "Verifying OS compatibility..."
    if [[ -f /etc/os-release ]]; then
        # Check if the OS ID is arch or if it inherits from arch
        if grep -qE '^ID=arch|^ID_LIKE=.*arch' /etc/os-release; then
            log_success "System verified as Arch Linux (or Arch-based)."
        else
            log_error "Unsupported OS. This installer is designed specifically for Arch Linux."
            exit 1
        fi
    else
        log_error "/etc/os-release not found. Cannot verify OS compatibility."
        exit 1
    fi
}

check_root() {
    log_info "Checking user privileges..."
    
    # Building packages (especially with makepkg/paru) as root is dangerous and forbidden.
    if [[ "$EUID" -eq 0 ]]; then
        log_error "This script should NOT be run as root directly."
        log_info "AUR packages cannot be built as root. Please run as a normal user with sudo privileges."
        exit 1
    fi

    # Verify sudo is available on the system
    if ! command_exists sudo; then
        log_error "The 'sudo' command is not installed. Please install sudo and configure user privileges."
        exit 1
    fi

    # Refresh sudo credentials early, prompting for password if necessary.
    log_info "Requesting sudo authentication (needed for system package installations)..."
    if ! sudo -v; then
        log_error "Sudo authorization failed."
        exit 1
    fi
    
    # Keep sudo alive in the background while the installer runs
    start_sudo_keepalive
    
    log_success "Sudo access verified and cached."
}

check_internet() {
    log_info "Checking internet connectivity..."
    
    # Try a fast ping to Cloudflare DNS with a 3-second timeout
    if ping -c 1 -W 3 1.1.1.1 >/dev/null 2>&1; then
        log_success "Internet connection detected."
        return 0
    fi
    
    # Fallback to an HTTP request to archlinux.org in case ping is blocked on the network
    if command_exists curl && curl -s --connect-timeout 3 https://www.archlinux.org >/dev/null; then
        log_success "Internet connection detected (via HTTP fallback)."
        return 0
    fi

    log_error "No internet connection detected. Please check your network configuration."
    exit 1
}

check_dependencies() {
    log_info "Checking pre-requisite installer dependencies..."
    
    # We only strictly require 'sudo' to begin the installation process.
    # Other tools like 'git', 'curl', and 'ping' (iputils) will be installed
    # during the 'install_official_packages' step if they are missing.
    if ! command_exists sudo; then
        log_error "The 'sudo' command is missing."
        log_info "Please install sudo and configure user privileges before running this installer."
        exit 1
    fi

    log_success "Initial dependencies satisfied."
}
