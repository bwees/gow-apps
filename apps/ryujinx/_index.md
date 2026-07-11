# Ryujinx

Nintendo Switch emulator (community-maintained fork, v1.3.3) running in a
Games-on-Whales container with GPU acceleration.

## Game library

The Wolf runner bind-mounts a host directory into the container at `/games`
(see `mounts` in `wolf.config.toml`). On first launch, open **Options →
Settings → Game Directories** in Ryujinx and add `/games`.

## Firmware & keys

Ryujinx needs Nintendo Switch firmware and `prod.keys` / `title.keys`.
Install them from the Ryujinx UI (**Tools → Install Firmware**, **Actions →
Open Ryujinx Folder** to drop keys into `system/`). They persist under
`$HOME/.config/Ryujinx/` in the container's home volume.
