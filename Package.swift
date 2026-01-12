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
            url: "https://github.com/Entertech/webrtc-audio-processing-build/releases/download/v137.7151.11.1/AGC2Capi.xcframework.zip",
            checksum: "0b9c10bcca388fe79a7c4b8c1754cbba4a720c82b3ce9d9852821cb7ac2e4b79"
        )
    ]
)
