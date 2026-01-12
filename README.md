# webrtc-build

webrtc build scripts

## Build Tools

Use dart-lang to build cross-platform compilation [tools](tools).

## AGC2 Packaging

Use `webrtc-build/build/run.py` to produce AGC2-only artifacts:
- `python3 webrtc-build/build/run.py build agc2_apple` creates `spm/AGC2Capi.xcframework`.
- `python3 webrtc-build/build/run.py package agc2_apple` copies the xcframework to `_package/agc2_apple`.
- `python3 webrtc-build/build/run.py build agc2_android` creates `agc2capi.aar`.
- `python3 webrtc-build/build/run.py package agc2_android` copies the AAR to `_package/agc2_android`.
