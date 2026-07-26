#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${COLORS_LOADED:-}" ]]; then
    return
fi
COLORS_LOADED=1

# colors.sh - Color definitions for terminal output.
# Avoid unnecessary global variables by defining them with empty defaults
# and initializing them only when initialize_colors is explicitly called.

COLOR_RESET=""
COLOR_INFO=""
COLOR_SUCCESS=""
COLOR_WARNING=""
COLOR_ERROR=""

initialize_colors() {
    # Only initialize colors if stdout is a terminal (tty)
    if [[ -t 1 ]]; then
        if command -v tput >/dev/null 2>&1; then
            COLOR_RESET="$(tput sgr0)"
            COLOR_INFO="$(tput setaf 4)$(tput bold)"     # Bold Blue
            COLOR_SUCCESS="$(tput setaf 2)$(tput bold)"  # Bold Green
            COLOR_WARNING="$(tput setaf 3)$(tput bold)"  # Bold Yellow
            COLOR_ERROR="$(tput setaf 1)$(tput bold)"    # Bold Red
        else
            COLOR_RESET=$'\e[0m'
            COLOR_INFO=$'\e[1;34m'
            COLOR_SUCCESS=$'\e[1;32m'
            COLOR_WARNING=$'\e[1;33m'
            COLOR_ERROR=$'\e[1;31m'
        fi
    else
        COLOR_RESET=""
        COLOR_INFO=""
        COLOR_SUCCESS=""
        COLOR_WARNING=""
        COLOR_ERROR=""
    fi
}
