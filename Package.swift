// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "WebRTCAudio",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "WebRTCAudio",
            targets: ["WebRTCAudio"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "WebRTCAudio",
            url: "https://github.com/Entertech/webrtc-audio-processing-build/releases/download/v0.0.0-pre/ExportAudio.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        )
    ]
)
