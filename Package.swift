// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "TJScaleTipper",
    platforms: [.iOS(.v13), .tvOS(.v13), .macCatalyst(.v13)],
    products: [
        .library(
            name: "TJScaleTipper",
            targets: ["TJScaleTipper"]
        )
    ],
    targets: [
        .target(
            name: "TJScaleTipper",
            path: ".",
            sources: ["TJScaleTipper.m"],
            publicHeadersPath: "."
        )
    ]
)
