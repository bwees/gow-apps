# gow-apps

Personal collection of [games-on-whales](https://github.com/games-on-whales/gow) apps for use with [Wolf](https://github.com/games-on-whales/wolf).

## Apps

| App       | Variants       | Published image                           |
| --------- | -------------- | ----------------------------------------- |
| ryujinx   | fedora, debian | `ghcr.io/bwees/ryujinx-{fedora,debian}`   |
| eglantine | fedora, debian | `ghcr.io/bwees/eglantine-{fedora,debian}` |

## Layout

```
apps/<name>/
  _index.md
  assets/wolf.config.toml    # example Wolf app entry
  build/                     # Debian variant (base-app:edge)
    Dockerfile
    scripts/startup.sh
  build-fedora/              # Fedora variant (base-app:fedora)
    Dockerfile
    scripts/startup.sh
```

## Build locally

```bash
./build.sh <app> <variant:fedora|debian>    # → custom/<app>-<variant>:latest
```

## Wolf setup

For each app, `apps/<name>/assets/wolf.config.toml` shows the
`[[profiles.apps]]` entry to paste under your desired profile in
`/etc/wolf/cfg/config.toml`. Adjust `mounts` to your host paths.

## Notice

All applications are sourced from their respective upstream projects. This repository is not affiliated with any of the upstream projects, and is provided for convenience only. Please refer to the upstream projects for support and issues.

No application binaries or game resources are included in this repository. You must obtain them from the upstream projects/sources and place them in the appropriate directories as specified in the `wolf.config.toml` files.
