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
            checksum: "4669ac2cfbf97376257257039c39d5b7337d32c4b034931914894920954d6ec3"
        )
    ]
)
