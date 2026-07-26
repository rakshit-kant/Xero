#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${ZSH_LOADED:-}" ]]; then
    return
fi
ZSH_LOADED=1

install_zsh() {
    log_info "Installing Zsh..."

    if command_exists zsh; then
        log_success "Zsh is already installed."
        return 0
    fi

    sudo pacman -S --needed --noconfirm zsh

    log_success "Zsh installed successfully."
}

backup_zsh_configs() {
    log_info "Backing up existing Zsh configuration..."

    local backup_dir="$HOME/.zsh_backup"

    mkdir -p "$backup_dir"

    if [[ -f "$HOME/.zshrc" ]]; then
        mv "$HOME/.zshrc" "$backup_dir/.zshrc"
        log_warning "Existing .zshrc backed up."
    fi

    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        mv "$HOME/.oh-my-zsh" "$backup_dir/.oh-my-zsh"
        log_warning "Existing Oh My Zsh backed up."
    fi

    log_success "Backup completed."
}

clone_zsh_dotfiles() {
    log_info "Cloning Zsh dotfiles..."

    local repo="https://github.com/rakshit-kant/zsh.git"
    local clone_dir="/tmp/zsh-dotfiles"

    rm -rf "$clone_dir"

    git clone "$repo" "$clone_dir"

    log_success "Zsh dotfiles cloned."
}

install_zsh_dotfiles() {
    log_info "Installing Zsh dotfiles..."

    local source="/tmp/zsh-dotfiles"

    if [[ ! -f "$source/.zshrc" ]]; then
        log_error ".zshrc missing from Zsh repository."
        exit 1
    fi

    if [[ ! -d "$source/.oh-my-zsh" ]]; then
        log_error ".oh-my-zsh missing from Zsh repository."
        exit 1
    fi

    cp "$source/.zshrc" "$HOME/.zshrc"

    cp -r "$source/.oh-my-zsh" "$HOME/.oh-my-zsh"

    # Copy extra zsh files if they exist
    for file in "$source"/*.zsh; do
        if [[ -f "$file" ]]; then
            cp "$file" "$HOME/"
        fi
    done

    log_success "Zsh configuration installed."
}

install_zsh_dependencies() {
    log_info "Installing Zsh dependencies..."

    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"

    mkdir -p "$plugins_dir"

    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        git clone \
            https://github.com/zsh-users/zsh-autosuggestions \
            "$plugins_dir/zsh-autosuggestions"
    fi

    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        git clone \
            https://github.com/zsh-users/zsh-syntax-highlighting \
            "$plugins_dir/zsh-syntax-highlighting"
    fi

    log_success "Zsh plugins installed."
}

set_default_shell() {
    log_info "Setting Zsh as default shell..."

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
        log_success "Default shell changed to Zsh."
    else
        log_success "Zsh is already the default shell."
    fi
}

cleanup_zsh() {
    log_info "Cleaning temporary Zsh files..."

    rm -rf "/tmp/zsh-dotfiles"

    log_success "Cleanup completed."
}

setup_zsh() {
    install_zsh
    backup_zsh_configs
    clone_zsh_dotfiles
    install_zsh_dotfiles
    install_zsh_dependencies
    set_default_shell
    cleanup_zsh
}
