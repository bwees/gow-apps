#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Eglantine"

QT_CONFIG="$HOME/.config/eglantine/qt-config.ini"
MARIO_KART_WORLD_SHADER_DIR="$HOME/.cache/eglantine/shader/0400c3f00006e000"

# Eglantine creates this cache dir non-recursively and runs without a shader cache when that fails
mkdir -p "$MARIO_KART_WORLD_SHADER_DIR"

set_ui_setting() {
  KEY="$1" VALUE="$2" awk '
    BEGIN { key = ENVIRON["KEY"]; value = ENVIRON["VALUE"] }
    /^\[/ { section = $0 }
    section == "[UI]" && (index($0, key "=") == 1 || index($0, key "\\default=") == 1) { next }
    { print }
    $0 == "[UI]" { print key "\\default=false"; print key "=" value }
  ' "$QT_CONFIG" > "$QT_CONFIG.tmp"
  mv "$QT_CONFIG.tmp" "$QT_CONFIG"
}

if [ ! -f "$QT_CONFIG" ]; then
  mkdir -p "$(dirname "$QT_CONFIG")"
  printf '[UI]\n' > "$QT_CONFIG"
elif ! grep -q '^\[UI\]$' "$QT_CONFIG"; then
  printf '\n[UI]\n' >> "$QT_CONFIG"
fi
set_ui_setting 'fullscreen' 'true'
# Leaving fullscreen inside sway's fullscreen window leaves the old frame on screen
set_ui_setting 'Shortcuts\Main%20Window\Exit%20Fullscreen\KeySeq' ''

export QT_QPA_PLATFORM=xcb

source /opt/gow/launch-comp.sh
launcher /opt/eglantine/AppRun "$@"
