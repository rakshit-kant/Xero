#!/usr/bin/env bash

set -euo pipefail

install_official_packages() {
    sudo pacman -needed -Syu hyprland \
        waybar \
        wezterm \
        hyprlock \
        hypridle \
        awww \
        hyprshot \
        swaync \
        sddm \
        wayland \
        wayland-protocols \
        qt5-wayland \
        qt6-wayland \
        seatd \
        pipewire \
        pipewire-pulse \
        wireplumber \
        pavucontrol \
        pamixer \
        pulsemixer \
        polkit-gnome \
        networkmanager \
        network-manager-applet \
        git \
        curl \
        wget \
        iputils \
        sudo \
        base-devel \
        bluez \
        bluez-utils \
        blueman \
        brightnessctl \
        grim \
        slurp \
        swappy \
        wl-clipboard \
        cliphist \
        xdg-desktop-portal \
        xdg-desktop-portal-hyprland \
        xdg-user-dirs \
        xdg-utils \
        git \
        neovim \
        fastfetch \
        btop \
        ripgrep \
        fd \
        fzf \
        eza \
        bat \
        jq \
        tree \
        unzip \
        zip \
        p7zip \
        zsh \
        zoxide \
        imv \
        zathura \
        zathura-pdf-mupdf \
        base-devel \
        gcc \
        clang \
        lldb \
        cmake \
        ninja \
        valgrind \
        meson \
        pkgconf \
        celluloid \
        playerctl \
        udiskie \
        gvfs \
        gvfs-mtp \
        adwaita-icon-theme \
        qt5ct \
        qt6ct \
        kvantum \
        noto-fonts \
        noto-fonts-cjk \
        noto-fonts-emoji
}

install_aur_packages() {
    paru -S walker \
        wlroots \
        ttf-jetbrains-mono-nerd \
        bibata-cursor-theme \
        grimblast-git \
        wiremix
}
