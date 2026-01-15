#!/bin/bash

set -e

cd "$(dirname "$0")"

COMMIT="${1:-}"
MODE="${2:-release}"

echo "Building Apple Export Audio frameworks..."
echo "Commit: ${COMMIT:-HEAD}"
echo "Mode: $MODE"

# Fetch source
if [[ -n "$COMMIT" ]]; then
  python3 run.py build apple_export_audio --commit "$COMMIT" --webrtc-fetch --shallow
else
  python3 run.py build apple_export_audio --webrtc-fetch --shallow
fi

# Add depot_tools to PATH
export PATH="$PWD/_source/apple_export_audio/depot_tools:$PATH"

# Build xcframework
mkdir -p _package/apple_export_audio
. apple_export_audio/xcframework.sh "$MODE" _source/apple_export_audio/webrtc/src _package/apple_export_audio

echo "Done! Output: _package/apple_export_audio/ExportAudio.xcframework.zip"
