#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Lichii"

export QT_QPA_PLATFORM=xcb

source /opt/gow/launch-comp.sh
launcher /opt/lichii/AppRun "$@"
