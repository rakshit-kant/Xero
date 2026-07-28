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
        "$SCRIPT_DIR/lib/paru.sh"
        "$SCRIPT_DIR/lib/rustup.sh"
        "$SCRIPT_DIR/lib/nvim.sh"
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

    run_step "Printing banner" print_banner
    run_step "Checking architecture" check_arch
    run_step "Checking root privileges" check_root
    run_step "Checking internet connectivity" check_internet
    run_step "Checking required dependencies" check_dependencies
    run_step "Installing official packages" install_official_packages
    run_step "Installing AUR packages" install_aur_packages
    run_step "Installing Rustup" install_rustup
    run_step "Installing Neovim configuration" install_nvim_config
    run_step "Displaying final summary" print_summary

    log "Installation completed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
