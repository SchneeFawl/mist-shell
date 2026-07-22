#!/usr/bin/env bash

set -u

RED="\033[38;5;202m"
BLUE="\033[38;5;33m"
CYAN="\033[38;5;45m"
GREEN="\033[38;5;34m"
YELLOW="\033[38;5;190m"
NC="\033[0m"        # no color

log_info()     { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success()  { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()    { echo -e "${RED}[ERROR]${NC} $1"; }

detect_pkg_manager() {
    if command -v pacman &> /dev/null; then
        echo "pacman"
    else
        echo "other"
    fi
}

manage_dependencies() {
    local missing=()
    local check_bins=(
        "quickshell" "hyprland" "hyprctl" "blueman-applet" "wpctl" "nmcli" "matugen" "awww" "rofi"
        "kitty" "zsh" "playerctl"
    )

    # packages (arch)
    local deps_pacman=(
        "hyprland" "kitty" "zsh" "playerctl" "networkmanager" "network-manager-applet" "pavucontrol"
        "pipewire" "pipewire-pulse" "wireplumber" "bluez" "bluez-utils" "blueman" "dolphin"
        "awww" "matugen" "rofi" "papirus-icon-theme" "starship"
        "gpu-screen-recorder" "gamemode"
        "qt6-declarative" "qt6-base" "qt6-wayland" "qt6-svg" "qt6-multimedia" "qt6-multimedia-ffmpeg"
        "qt6-imageformats" "qt6-shadertools" "qt6-positioning" "qt6-webengine" "libpipewire"
    )
    local deps_aur=(
        "otf-geist-mono-nerd" "ttf-cascadia-code-nerd" "ttf-cascadia-mono-nerd" "quickshell-git"
    )

    log_info "Checking system commands... "
    for bin in "${check_bins[@]}"; do
        if ! command -v "$bin" &> /dev/null; then
            missing+=("$bin")
        fi
    done

    local pkg_mgr
    pkg_mgr=$(detect_pkg_manager)

    if [ "$pkg_mgr" == "pacman" ]; then
        if [ ${#missing[@]} -ne 0 ]; then
            log_warning "Missing commands: ${missing[*]}"

            # install pacman packages
            echo -ne "${YELLOW}Do you want to install pacman dependencies?${NC} (y/N): "
            read -r response
            if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
                sudo pacman -S "${deps_pacman[@]}" --needed
            fi

            # install aur packagess
            if command -v yay &> /dev/null; then
                echo -ne "${YELLOW}Do you want to install AUR dependencies via yay?${NC} (y/N): "
                read -r response
                if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
                    yay -S --needed "${deps_aur[@]}"
                fi
            else
                log_error "AUR helper 'yay' not found. Please manually install dependencies: ${deps_aur[*]}"
            fi
        else
            log_success "All necessary dependencies are installed!\n"
        fi
    else
        if [ ${#missing[@]} -ne 0 ]; then
            log_error "You are on a non Arch system. Please manually install dependencies: ${deps_aur[*]}"
        else
            log_success "All necessary dependencies are installed!\n"
        fi
    fi
}

deploy_config() {
    local script_dir
    script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
    local source_dir="$script_dir/dots/.config"
    local target_dir="$HOME/.config"

    mkdir -p "$target_dir"

    log_info  "Deploying config files..."

    for item_path in "$source_dir"/*; do
        [ -e "$item_path" ] || continue

        local item_name
        item_name=$(basename "$item_path")
        local target_path="$target_dir/$item_name"

        # backup check
        if [ -L "$target_path" ]; then
            log_info "Removing existing sym-link at $target_path..."
            rm "$target_path"

        elif [ -d "$target_path" ]; then
            if [ "$(ls -A "$target_path")" ]; then
                local backup_name="${target_path}.bak"
                local counter=1

                while [ -e "$backup_name" ]; do
                    backup_name="${target_path}.bak.${counter}"
                    counter=$(( counter + 1 ))
                done

                log_warning "Existing config folder has files. Backing up to: $backup_name"
                mv "$target_path" "$backup_name"

            else
                log_info "Removing empty config folder at $target_path..."
                rmdir "$target_path"
            fi

        elif [ -f "$target_path" ]; then
            local backup_name="${target_path}.bak"
            local counter=1
            while [ -e "$backup_name" ]; do
                backup_name="${target_path}.bak.${counter}"
                counter=$(( counter + 1 ))
            done

            log_info "Backing up existing file to: $backup_name"
            mv "$target_path" "$backup_name"
        fi

        # copy the items
        log_info "Copying $item_name to $target_dir"
        cp -r "$item_path" "$target_dir/"
        log_success "Deployed: $item_name\n"
    done
}

main() {
    echo -e "${CYAN}█▀▄▀█ █ █▀ ▀█▀   █▀ █ █ █▀▀ █   █${NC}"
    echo -e "${CYAN}█░▀░█ █ ▄█  █    ▄█ █▀█ ██▄ █▄▄ █▄▄${NC}\n"
    echo -e "${YELLOW}-- Now Installing --${NC}\n"

    manage_dependencies
    deploy_config

    log_success "Installation completed successfully!\n"
}

main "$@"
