#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/Desktop"

CACHE_FILE="$HOME/.cache/xero-wallpaper"

TRANSITION="grow"

DURATION=2
FPS=60
STEP=90

# ----------------------------------------------------------
# Ensure awww daemon is running
# ----------------------------------------------------------

if ! pgrep -x awww-daemon >/dev/null; then
    awww-daemon &
    sleep 1
fi

# ----------------------------------------------------------
# Find wallpapers
# ----------------------------------------------------------

mapfile -t WALLPAPERS < <(
    find "$WALLPAPER_DIR" \
        -type f \
        \( \
        -iname "*.png" \
        -o -iname "*.jpg" \
        -o -iname "*.jpeg" \
        -o -iname "*.webp" \
        \)
)

if [ "${#WALLPAPERS[@]}" -eq 0 ]; then
    echo "No wallpapers found."
    exit 1
fi

# ----------------------------------------------------------
# Select random wallpaper
# ----------------------------------------------------------

WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

# ----------------------------------------------------------
# Apply wallpaper
# ----------------------------------------------------------

awww img "$WALLPAPER" \
    --transition-type "$TRANSITION" \
    --transition-duration "$DURATION" \
    --transition-fps "$FPS" \
    --transition-step "$STEP"

# ----------------------------------------------------------
# Save current wallpaper
# ----------------------------------------------------------

mkdir -p "$(dirname "$CACHE_FILE")"

echo "$WALLPAPER" >"$CACHE_FILE"

echo "Wallpaper changed:"
echo "$WALLPAPER"
