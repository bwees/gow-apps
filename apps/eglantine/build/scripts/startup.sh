#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh

gow_log "Starting Eglantine"

source /opt/gow/launch-comp.sh
launcher /opt/eglantine/AppRun "$@"
