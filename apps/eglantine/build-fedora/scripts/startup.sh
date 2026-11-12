#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Eglantine"

QT_CONFIG="$HOME/.config/eglantine/qt-config.ini"
MARIO_KART_WORLD_SHADER_DIR="$HOME/.cache/eglantine/shader/0400c3f00006e000"

# Eglantine creates this cache dir non-recursively and runs without a shader cache when that fails
mkdir -p "$MARIO_KART_WORLD_SHADER_DIR"

if [ ! -f "$QT_CONFIG" ]; then
  mkdir -p "$(dirname "$QT_CONFIG")"
  printf '[UI]\n' > "$QT_CONFIG"
elif ! grep -q '^\[UI\]$' "$QT_CONFIG"; then
  printf '\n[UI]\n' >> "$QT_CONFIG"
fi
sed -i \
  -e '/^\[UI\]$/,/^\[/{/^fullscreen\(\\default\)\?=/d}' \
  -e '/^\[UI\]$/a fullscreen\\default=false\nfullscreen=true' \
  "$QT_CONFIG"

export QT_QPA_PLATFORM=xcb

source /opt/gow/launch-comp.sh
launcher /opt/eglantine/AppRun "$@"
