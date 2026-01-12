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
            url: "https://github.com/Entertech/webrtc-audio-processing-build/releases/download/v137.7151.12/AGC2Capi.xcframework.zip",
            checksum: "d92e987bbcadc6efd8e03e963c5905664cd64931216afbb12049c1917d0cdcc4"
        )
    ]
)
