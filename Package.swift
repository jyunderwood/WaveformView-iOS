// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "WaveformView-iOS",
    products: [
        .library(
            name: "WaveformView-iOS",
            targets: ["WaveformView-iOS"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WaveformView-iOS",
            dependencies: [],
            path: "WaveformView/WaveformView")
    ]
)
