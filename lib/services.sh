#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${SERVICES_LOADED:-}" ]]; then
    return
fi
SERVICES_LOADED=1

# services.sh - Library for managing and enabling system-level systemd services.

enable_system_services() {
    log_info "Enabling and starting system-level services..."

    # The required services to enable and start immediately
    local services=("NetworkManager" "bluetooth" "sddm")

    for service in "${services[@]}"; do
        log_info "Enabling and starting system service: $service"
        
        # systemctl enable --now enables the service to start on boot and starts it immediately.
        # This requires administrative privileges (sudo).
        if ! sudo systemctl enable --now "$service"; then
            log_error "Failed to enable and start system service: $service"
            exit 1
        fi
    done

    log_success "All system-level services have been enabled and started successfully."
}
