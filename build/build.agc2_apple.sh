#!/bin/bash

set -e

cd "$(dirname "$0")"

COMMIT="${1:-}"
MODE="${2:-release}"

echo "Building AGC2 Apple frameworks..."
echo "Commit: ${COMMIT:-HEAD}"
echo "Mode: $MODE"

# Fetch source
if [[ -n "$COMMIT" ]]; then
  python3 run.py build agc2_apple --commit "$COMMIT" --webrtc-fetch
else
  python3 run.py build agc2_apple --webrtc-fetch
fi

# Add depot_tools to PATH
export PATH="$PWD/_source/agc2_apple/depot_tools:$PATH"

# Build xcframework
mkdir -p _package/agc2_apple
. agc2/xcframework.sh "$MODE" _source/agc2_apple/webrtc/src _package/agc2_apple

echo "Done! Output: _package/agc2_apple/AGC2Capi.xcframework.zip"
