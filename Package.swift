// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "findertag",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "findertag",
            dependencies: ["Utility"]),
        
        
//        .testTarget(
//            name: "findertagTest",
//            dependencies: ["findertag"]),
    ]
)
