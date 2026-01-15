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
            url: "https://github.com/Entertech/webrtc-audio-processing-build/releases/download/v137.7151.11/ExportAudio.xcframework.zip",
            checksum: "fe3e507881e701a870829c64b1afff4801967a3a32a0cadf96ca878110f7c2ff"
        )
    ]
)
