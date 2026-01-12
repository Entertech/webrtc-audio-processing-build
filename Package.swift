// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "AGC2Capi",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "AGC2Capi",
            targets: ["AGC2Capi"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AGC2Capi",
            url: "https://github.com/Entertech/webrtc-audio-processing-build/releases/download/v0.0.0-pre/AGC2Capi.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        )
    ]
)
