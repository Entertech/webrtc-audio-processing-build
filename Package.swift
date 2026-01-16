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
            path: "swift/ExportAudio.xcframework"
        )
    ]
)
