#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Ryujinx"

# Ryujinx stores its config, saves, firmware, and keys under
# $HOME/.config/Ryujinx — persisted across container restarts via the
# runner's home volume. Nothing to seed here; users configure the games
# directory (/games) and install firmware/keys on first launch.
mkdir -p "${HOME}/.config/Ryujinx"

source /opt/gow/launch-comp.sh
launcher /opt/ryujinx/Ryujinx.sh "$@"
