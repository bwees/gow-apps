#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Eglantine"

QT_CONFIG="$HOME/.config/eglantine/qt-config.ini"
MARIO_KART_WORLD_SHADER_DIR="$HOME/.cache/eglantine/shader/0400c3f00006e000"
BORDERLESS_FULLSCREEN_MODE=0

# Eglantine creates this cache dir non-recursively and runs without a shader cache when that fails
mkdir -p "$MARIO_KART_WORLD_SHADER_DIR"

set_setting() {
  grep -qxF "[$1]" "$QT_CONFIG" || printf '\n[%s]\n' "$1" >> "$QT_CONFIG"
  SECTION="[$1]" KEY="$2" VALUE="$3" awk '
    BEGIN { target = ENVIRON["SECTION"]; key = ENVIRON["KEY"]; value = ENVIRON["VALUE"] }
    /^\[/ { section = $0 }
    section == target && (index($0, key "=") == 1 || index($0, key "\\default=") == 1) { next }
    { print }
    $0 == target { print key "\\default=false"; print key "=" value }
  ' "$QT_CONFIG" > "$QT_CONFIG.tmp"
  mv "$QT_CONFIG.tmp" "$QT_CONFIG"
}

mkdir -p "$(dirname "$QT_CONFIG")"
touch "$QT_CONFIG"
set_setting 'UI' 'fullscreen' 'true'
# Exclusive fullscreen leaves the game drawn at a stale window size after exiting fullscreen
set_setting 'Renderer' 'fullscreen_mode' "$BORDERLESS_FULLSCREEN_MODE"

export QT_QPA_PLATFORM=xcb

source /opt/gow/launch-comp.sh
launcher /opt/eglantine/AppRun "$@"
