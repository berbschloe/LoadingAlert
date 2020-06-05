// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "LoadingAlert",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "LoadingAlert", targets: ["LoadingAlert"]),
    ],
    targets: [
        .target(name: "LoadingAlert", path: "LoadingAlert"),
        .testTarget(name: "LoadingAlertTests", dependencies: ["LoadingAlert"]),
    ]
)
