#!/usr/bin/env bash
set -euo pipefail

APP_NAME=${1:?"usage: $0 <app> [fedora|debian]"}
VARIANT=${2:-fedora}

case "$VARIANT" in
    fedora)
        BUILD_DIR="apps/${APP_NAME}/build-fedora"
        BASE_APP_IMAGE="ghcr.io/games-on-whales/base-app:fedora"
        IMAGE_TAG="${APP_NAME}-fedora"
        ;;
    debian)
        BUILD_DIR="apps/${APP_NAME}/build"
        BASE_APP_IMAGE="ghcr.io/games-on-whales/base-app:edge"
        IMAGE_TAG="${APP_NAME}"
        ;;
    *)
        echo "unknown variant: $VARIANT (fedora|debian)" >&2
        exit 1
        ;;
esac

if [ ! -d "$BUILD_DIR" ]; then
    echo "no such build dir: $BUILD_DIR" >&2
    exit 1
fi

echo "======================================"
echo "🔨 Building custom/${IMAGE_TAG} from ${BASE_APP_IMAGE}"
docker build \
    --build-arg BASE_APP_IMAGE="${BASE_APP_IMAGE}" \
    -t "custom/${IMAGE_TAG}:latest" \
    "${BUILD_DIR}" \
    --progress=plain
echo "🌟 Built custom/${IMAGE_TAG}:latest"
