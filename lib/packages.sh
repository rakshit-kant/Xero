#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${PACKAGES_LOADED:-}" ]]; then
    return
fi
PACKAGES_LOADED=1

# packages.sh - Centralized definitions of packages to install.
# Consolidating these lists here ensures there is a single source of truth.

OFFICIAL_PACKAGES=(
    # Window Manager & Core Desktop Components
    hyprland
    waybar
    walker
    wezterm
    hyprlock
    hypridle
    hyprpaper
    swaync
    sddm

    # Wayland Essentials
    wayland
    wayland-protocols
    wlroots
    qt5-wayland
    qt6-wayland
    seatd

    # Audio & Sound System
    pipewire
    pipewire-pulse
    wireplumber
    pavucontrol
    pamixer
    pulsemixer

    # Polkit Agent
    polkit-gnome

    # Network Utilities
    networkmanager
    network-manager-applet

    # Bootstrap & Core Utilities
    git
    curl
    wget
    iputils
    sudo
    base-devel

    # Bluetooth Utilities
    bluez
    bluez-utils
    blueman

    # Hardware Control
    brightnessctl

    # Screenshot & Clipboard Management
    grim
    slurp
    swappy
    wl-clipboard
    cliphist

    # File Manager & Archive Support
    thunar
    thunar-archive-plugin

    # XDG Portals & User Directories
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-utils

    # Version Control & Editors
    git
    neovim

    # System Utilities & Shell Enhancements
    fastfetch
    btop
    ripgrep
    fd
    fzf
    eza
    bat
    jq
    tree
    unzip
    zip
    p7zip
    zsh
    zoxide

    # Document & Image Viewers
    imv
    zathura
    zathura-pdf-mupdf

    # Compilers & Build Tools (Required for building AUR packages and local dev)
    base-devel
    gcc
    clang
    cmake
    ninja
    valgrind
    meson
    pkgconf

    # Media Control & Device Mounting
    celluloid
    playerctl
    udiskie
    gvfs
    gvfs-mtp

    # Qt Theme & Appearance Configuration
    qt5ct
    qt6ct
    kvantum

    # System Fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
)

AUR_PACKAGES=(
    ttf-jetbrains-mono-nerd
    # Screenshot workflow enhancement
    grimblast-git
    # Additional audio utilities
    wiremix
)
