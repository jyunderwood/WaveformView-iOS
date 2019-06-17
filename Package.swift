// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WaveformView",
    products: [
        .library(
            name: "WaveformView",
            targets: ["WaveformView"]),
    ],
    targets: [
        .target(
            name: "WaveformView",
            dependencies: []),
        .testTarget(
            name: "WaveformViewTests",
            dependencies: ["WaveformView"]),
    ]
)
