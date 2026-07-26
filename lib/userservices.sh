#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${USERSERVICES_LOADED:-}" ]]; then
    return
fi
USERSERVICES_LOADED=1

# userservices.sh - Library for managing and enabling user-level systemd services.

enable_user_services() {
    log_info "Enabling and starting user-level services..."

    # Mask potential conflicting portal services when using Hyprland
    log_info "Checking for conflicting XDG portal services..."
    if systemctl --user list-unit-files | grep -q xdg-desktop-portal-kde; then
        log_info "Masking xdg-desktop-portal-kde.service..."
        systemctl --user mask xdg-desktop-portal-kde.service
    fi

    # The required user-level services to enable and start immediately
    local user_services=("pipewire" "pipewire-pulse" "wireplumber")

    for service in "${user_services[@]}"; do
        log_info "Enabling and starting user service: $service"
        
        # User services MUST be enabled/started without sudo.
        # They will run under the logged-in user's context.
        if ! systemctl --user enable --now "$service"; then
            log_error "Failed to enable and start user service: $service"
            exit 1
        fi
    done

    log_success "All user-level services have been enabled and started successfully."
}
