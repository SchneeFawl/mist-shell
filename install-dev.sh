#!/usr/bin/env bash

# terminate script if any errors occur
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DOTS="$REPO_ROOT/dots"

# mapping handler
link_xdg_directory() {
    local source_parent="$1"
    local target_parent="$2"

    # if source folder dont exist, skip it
    if [ ! -d "$source_parent" ]; then
        return
    fi

    mkdir -p "$target_parent"

    for item in "$source_parent"/*; do
        [ -e "$item" ] || continue

        local name=$(basename "$item")
        local target_path="$target_parent/$name"

        echo "Deploying target: $target_path"

        # backup
        if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
            echo "-> Backup: Moving active config to ${target_path}.bak"
            mv "$target_path" "${target_path}.bak"
        fi

        # clear out any broken or older symlinks
        if [ -L "$target_path" ] || [ -e "$target_path" ]; then
            rm -rf "$target_path"
        fi

        ln -sf "$item" "$target_path"
        echo "--> Link established!"
    done
}

# proces xdg base directory structure dynamically
link_xdg_directory "$REPO_DOTS/.config" "$HOME/.config"
#link_xdg_directory "$REPO_DOTS/.local/share" "$HOME/.local/share"

echo "Completed mapping workspace"

echo "! Reloading Hyprland configuration !"
hyprctl reload
