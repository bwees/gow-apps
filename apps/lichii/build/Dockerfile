ARG BASE_APP_IMAGE

# hadolint ignore=DL3006
FROM ${BASE_APP_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

# The AppImage bundles Qt, ffmpeg, and its other deps. These are the system
# libs linuxdeploy leaves out: GL/Vulkan, X11/Wayland client libs, fonts.
ARG REQUIRED_PACKAGES=" \
    libvulkan1 \
    libgl1 \
    libegl1 \
    libopengl0 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcb-cursor0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libfontconfig1 \
    libfreetype6 \
    fontconfig \
    "

RUN apt-get update && \
    apt-get install -y --no-install-recommends $REQUIRED_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

ARG LICHII_RELEASE=build-130
RUN curl -fsSL --retry 5 --retry-all-errors --retry-delay 2 --retry-max-time 120 \
      -o /tmp/lichii.AppImage \
      "https://github.com/zortos293/Lichii/releases/download/${LICHII_RELEASE}/lichii-linux-x86_64.AppImage" && \
    chmod +x /tmp/lichii.AppImage && \
    cd /tmp && ./lichii.AppImage --appimage-extract >/dev/null && \
    mv /tmp/squashfs-root /opt/lichii && \
    chmod -R a+rX /opt/lichii && \
    rm /tmp/lichii.AppImage && \
    ln -sf /opt/lichii/AppRun /usr/local/bin/lichii

RUN mkdir -m 0755 /games

COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source=$IMAGE_SOURCE
