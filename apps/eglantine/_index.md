# Eglantine

Experimental Nintendo Switch 2 emulator ([Eglantine-Community/Eglantine](https://github.com/Eglantine-Community/Eglantine),
Eden/yuzu-derived) running in a Games-on-Whales container with GPU
acceleration. Built from the upstream x86_64 AppImage, extracted to
`/opt/eglantine`. Bump `EGLANTINE_RELEASE` in the Dockerfiles to update.

## Game library

The Wolf runner bind-mounts a host directory into the container at `/games`
(see `mounts` in `wolf.config.toml`). On first launch, double-click the game
list and add `/games`.

## Firmware & keys

Install them from the UI: **Tools → Install Decryption Keys** and
**Tools → Install Firmware**. They persist under `$HOME/.local/share/` in the
container's home volume.
