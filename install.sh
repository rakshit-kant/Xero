#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

log() {
    printf '==> %s\n' "$*"
}

run_step() {
    local description="$1"
    shift

    log "$description"
    "$@" || die "Step failed: $description"
}

load_libraries() {
    local lib
    local -a required_libs=(
        "$SCRIPT_DIR/lib/colors.sh"
        "$SCRIPT_DIR/lib/utils.sh"
        "$SCRIPT_DIR/lib/packages.sh"
        "$SCRIPT_DIR/lib/checks.sh"
        "$SCRIPT_DIR/lib/pacman.sh"
        "$SCRIPT_DIR/lib/paru.sh"
        "$SCRIPT_DIR/lib/aur.sh"
        "$SCRIPT_DIR/lib/rustup.sh"
        "$SCRIPT_DIR/lib/nvim.sh"
        "$SCRIPT_DIR/lib/zsh.sh"
        "$SCRIPT_DIR/lib/configs.sh"
        "$SCRIPT_DIR/lib/wallpaper.sh"
        "$SCRIPT_DIR/lib/services.sh"
        "$SCRIPT_DIR/lib/userservices.sh"
    )

    for lib in "${required_libs[@]}"; do
        if [[ ! -f "$lib" ]]; then
            die "Required library not found: $lib"
        fi
    done

    for lib in "${required_libs[@]}"; do
        # shellcheck disable=SC1090
        source "$lib"
    done
}

main() {
    log "Loading installer libraries"
    load_libraries

    run_step "Initializing colors" initialize_colors
    run_step "Printing banner" print_banner
    run_step "Checking architecture" check_arch
    run_step "Checking root privileges" check_root
    run_step "Checking internet connectivity" check_internet
    run_step "Checking required dependencies" check_dependencies
    run_step "Synchronizing pacman databases" synchronize_pacman
    run_step "Installing official packages" install_official_packages
    run_step "Installing Paru" install_paru
    run_step "Installing AUR packages" install_aur_packages
    run_step "Installing Rustup" install_rustup
    run_step "Installing configuration files" install_configs
    run_step "Installing Hyprland configuration" install_hypr_config
    run_step "Installing Hyprland scripts" install_hypr_scripts
    run_step "Installing Neovim configuration" install_nvim_config
    run_step "Setting up Zsh environment" setup_zsh
    run_step "Enabling system services" enable_system_services
    run_step "Enabling user services" enable_user_services
    run_step "Creating Wayland session for Hyprland" create_wayland_session
    run_step "Creating XDG directories" create_xdg_directories
    run_step "Installing wallpapers" install_wallpapers
    run_step "Cleaning up temporary files" cleanup
    run_step "Displaying final summary" print_summary

    log "Installation completed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
