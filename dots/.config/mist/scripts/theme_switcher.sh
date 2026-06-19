#!/bin/env bash

THEME_NAME=$1
WALLPAPER=$2
MODE=$3
MIST_DIR="$HOME/.config/mist"
THEME_PATH="$MIST_DIR/themes/$THEME_NAME"

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
    echo -e "\033[4mUsage:\033[0m $(basename "$0") <theme-name> <wallpaper-name> <mode>"
    echo "<mode> can be 'dark' or 'light'"
    echo -e "<wallpaper-name> must contain the .png, .jpg etc\n"
    echo -e "\033[4mExample:\033[0m $(basename "$0") Mist dark"
    exit 1
fi

if [ ! -d "$THEME_PATH" ]; then
    echo "Error: Theme '$THEME_NAME' does not exist in '$MIST_DIR/themes/'"
    exit 1
fi

WALLPAPERS_PATH="$THEME_PATH/wallpapers"

if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpaper image found in $WALLPAPERS_PATH"
    exit 1
fi

echo "Switching theme to '$THEME_NAME'..."
echo "Wallpaper: '$WALLPAPER'"


if command -v matugen &> /dev/null; then
    matugen image "$WALLPAPERS_PATH/$WALLPAPER" --mode "$MODE"
    echo -e "Successfully updated color schemes\n"
else
    echo -e "Warning: matugen command not found. Did you forget to install it?\n"
    exit 1
fi

if command -v awww &> /dev/null; then
    awww img "$WALLPAPERS_PATH/$WALLPAPER"
    echo -e "Successfully updated wallpaper\n"
else
    echo -e "Warning: awww ocmmand not found. Did you forget to install it?\n"
    exit
fi

echo -e "\033[4mTheme swap complete!\033[0m"
