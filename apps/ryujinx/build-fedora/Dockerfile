ARG BASE_APP_IMAGE=ghcr.io/games-on-whales/base-app:fedora

# hadolint ignore=DL3006
FROM ${BASE_APP_IMAGE}

# Ryujinx ships as a self-contained .NET publish (bundled runtime + Avalonia).
# We only need the shared libs it dlopens at runtime: ICU for globalization,
# OpenSSL, X11/GTK for the Avalonia backend, SDL2 for input, Vulkan.
RUN dnf install -y \
        libicu \
        openssl-libs \
        SDL2 \
        vulkan-loader \
        libX11 \
        libXext \
        libXrandr \
        libXcursor \
        libXi \
        libXinerama \
        gtk3 \
        mesa-libGL \
        mesa-libGLU \
        libnotify \
        fontconfig \
    && dnf clean all

# renovate: datasource=forgejo-releases depName=projects/Ryubing
ARG RYUJINX_VERSION=1.3.3
RUN curl -fsSL --retry 5 --retry-all-errors --retry-delay 2 --retry-max-time 120 \
      -o /tmp/ryujinx.tar.gz \
      "https://git.ryujinx.app/projects/Ryubing/releases/download/${RYUJINX_VERSION}/ryujinx-${RYUJINX_VERSION}-linux_x64.tar.gz" && \
    mkdir -p /opt/ryujinx && \
    tar -xzf /tmp/ryujinx.tar.gz --strip-components=1 -C /opt/ryujinx && \
    rm /tmp/ryujinx.tar.gz && \
    chmod +x /opt/ryujinx/Ryujinx /opt/ryujinx/Ryujinx.sh && \
    ln -sf /opt/ryujinx/Ryujinx.sh /usr/local/bin/ryujinx

# Host-mounted game library lives here; users add /games as a Games Directory
# in the Ryujinx UI on first launch (persisted via the container's $HOME volume).
RUN mkdir -m 0755 /games

COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source=$IMAGE_SOURCE
