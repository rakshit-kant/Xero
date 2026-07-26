#!/usr/bin/env bash

if [[ -n "${CONFIGS_LOADED:-}" ]]; then
    return
fi
CONFIGS_LOADED=1

# shellcheck source=lib/utils.sh
source "${SCRIPT_DIR}/lib/utils.sh"

install_configs() {
    local dry_run=false
    if [[ "${1:-}" == "--dry-run" ]]; then
        dry_run=true
    fi

    local config_src="${SCRIPT_DIR}/config"
    local config_dest="${HOME}/.config"
    local backup_dest="${HOME}/.config_backup"

    if [[ ! -d "${config_src}" ]]; then
        log_error "Source config directory not found: ${config_src}"
        return 1
    fi

    if [[ "${dry_run}" == "true" ]]; then
        log_info "Dry run enabled: No files will be modified."
    fi

    # Ensure dest directories exist
    if [[ "${dry_run}" == "false" ]]; then
        mkdir -p "${config_dest}" "${backup_dest}"
    fi

    # Iterate through items in config_src
    # Using a loop to handle spaces correctly
    for item in "${config_src}"/*; do
        local name
        name=$(basename "${item}")
        local dest_item="${config_dest}/${name}"
        local backup_item="${backup_dest}/${name}"

        # Check if item already exists in ~/.config
        if [[ -e "${dest_item}" ]]; then
            log_warning "Config '${name}' already exists in ${config_dest}. Moving to backup."
            if [[ "${dry_run}" == "true" ]]; then
                log_info "[DRY-RUN] Would move ${dest_item} to ${backup_item}"
            else
                # Clean old backup if it exists to allow move
                rm -rf "${backup_item}"
                mv "${dest_item}" "${backup_item}"
            fi
        fi

        log_info "Installing config: ${name}"
        if [[ "${dry_run}" == "true" ]]; then
            log_info "[DRY-RUN] Would copy ${item} to ${dest_item}"
        else
            cp -r "${item}" "${dest_item}"
        fi
    done

    if [[ "${dry_run}" == "true" ]]; then
        log_success "Dry run completed."
    else
        log_success "All configuration files installed successfully."
    fi
}

install_hypr_scripts() {
    log_info "Installing Hyprland scripts..."

    local source="$SCRIPT_DIR/config/hypr/scripts"
    local target="$HOME/.config/hypr/scripts"

    if [[ ! -d "$source" ]]; then
        log_warning "Hypr scripts not found. Skipping."
        return 0
    fi

    mkdir -p "$target"

    cp -r "$source/"* "$target/"

    chmod +x "$target"/*.sh

    log_success "Hyprland scripts installed."
}
