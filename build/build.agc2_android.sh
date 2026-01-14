#!/bin/bash

set -e

cd "$(dirname "$0")"

COMMIT="${1:-}"
MODE="${2:-release}"

echo "Building AGC2 Android..."
echo "Commit: ${COMMIT:-HEAD}"
echo "Mode: $MODE"

DEBUG="false"
if [[ "$MODE" == "debug" ]]; then
  DEBUG="true"
fi

# Fetch source
if [[ -n "$COMMIT" ]]; then
  python3 run.py build agc2_android --commit "$COMMIT" --webrtc-fetch
else
  python3 run.py build agc2_android --webrtc-fetch
fi

SOURCE_DIR="$PWD/_source/agc2_android/webrtc/src"
OUT_DIR="$PWD/_build/agc2_android"
PACKAGE_DIR="$PWD/_package/agc2_android"

# Add depot_tools to PATH
export PATH="$PWD/_source/agc2_android/depot_tools:$PATH"

PARALLEL_BUILDS=6

COMMON_ARGS="
  is_debug = $DEBUG
  is_java_debug = $DEBUG
  rtc_build_examples = false
  rtc_enable_protobuf = false
  rtc_include_tests = false
  treat_warnings_as_errors = false
  use_rtti = true
  use_custom_libcxx = false"

ARCHS=("armeabi-v7a:arm" "arm64-v8a:arm64" "x86:x86" "x86_64:x64")

cd "$SOURCE_DIR"

for arch_config in "${ARCHS[@]}"; do
  arch="${arch_config%%:*}"
  cpu="${arch_config#*:}"

  echo "=== Building AGC2 Android $arch ==="

  gn gen "$OUT_DIR/$arch" --args="$COMMON_ARGS target_os=\"android\" target_cpu=\"$cpu\""
  ninja -C "$OUT_DIR/$arch" sdk/android:agc2capi_jni -j $PARALLEL_BUILDS --quiet || exit 1
done

echo "=== Building AAR ==="

# Create AAR structure
AAR_WORK="$OUT_DIR/aar_work"
rm -rf "$AAR_WORK"
mkdir -p "$AAR_WORK"

# AndroidManifest.xml
cat > "$AAR_WORK/AndroidManifest.xml" << 'EOF'
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
  package="org.webrtc.agc2"/>
EOF

# Compile Java
JAVA_SRC="$SOURCE_DIR/sdk/android/api/org/webrtc/agc2/GainController2.java"
CLASSES_DIR="$AAR_WORK/classes"
mkdir -p "$CLASSES_DIR"
javac -source 8 -target 8 -d "$CLASSES_DIR" "$JAVA_SRC"

# Create classes.jar
jar cf "$AAR_WORK/classes.jar" -C "$CLASSES_DIR" .

# Copy native libraries
for arch_config in "${ARCHS[@]}"; do
  arch="${arch_config%%:*}"
  SO_SRC="$OUT_DIR/$arch/libagc2capi.so"
  SO_DST="$AAR_WORK/jni/$arch/libagc2capi.so"
  mkdir -p "$(dirname "$SO_DST")"
  cp "$SO_SRC" "$SO_DST"
done

# Create AAR
mkdir -p "$PACKAGE_DIR/aar"
AAR_PATH="$PACKAGE_DIR/aar/agc2capi.aar"
cd "$AAR_WORK"
zip -r "$AAR_PATH" .

echo "Done! Output: $AAR_PATH"
