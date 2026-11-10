# Lichii

Experimental Nintendo Switch 2 emulator ([zortos293/Lichii](https://github.com/zortos293/Lichii),
an Eglantine fork with extra GPU-thread performance work) running in a
Games-on-Whales container with GPU acceleration. Built from the upstream x86_64
AppImage, extracted to `/opt/lichii`. Bump `LICHII_RELEASE` in the Dockerfiles
to update.

## Game library

The Wolf runner bind-mounts a host directory into the container at `/games`
(see `mounts` in `wolf.config.toml`). On first launch, double-click the game
list and add `/games`.

## Firmware & keys

Install them from the UI: **Tools → Install Decryption Keys** and
**Tools → Install Firmware**. They persist under `$HOME/.local/share/` in the
container's home volume.
