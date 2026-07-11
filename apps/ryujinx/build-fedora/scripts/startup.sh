#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

LOG="/logs/ryujinx-launch.log"
mkdir -p /logs 2>/dev/null || true
exec > >(tee -a "$LOG") 2>&1

gow_log "Starting Ryujinx (log: $LOG)"
gow_log "env: HOME=$HOME USER=$USER DISPLAY=${DISPLAY:-<unset>} WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-<unset>} XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-<unset>}"
gow_log "id: $(id 2>&1)"
gow_log "ls /opt/ryujinx: $(ls /opt/ryujinx 2>&1 | head -5 | tr '\n' ' ')"
gow_log "--- full env ---"
env | sort
gow_log "--- end env ---"

mkdir -p "${HOME}/.config/Ryujinx" "${HOME}/Ryujinx"

source /opt/gow/launch-comp.sh
launcher /opt/ryujinx/Ryujinx.sh "$@"
