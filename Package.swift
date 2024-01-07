// swift-tools-version: 5.9
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import PackageDescription

let package = Package(
    name: "skip-stb",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipSTBImage", type: .dynamic, targets: ["SkipSTBImage"]),
        .library(name: "SkipSTBTrueType", type: .dynamic, targets: ["SkipSTBTrueType"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.7.40"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "0.0.0"),
        .package(url: "https://source.skip.tools/skip-ffi.git", from: "0.0.0")
    ],
    targets: [
        .target(name: "SkipSTBImage", dependencies: [
            "STBImage",
            .product(name: "SkipFoundation", package: "skip-foundation"),
            .product(name: "SkipFFI", package: "skip-ffi")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .testTarget(name: "SkipSTBImageTests", dependencies: [
            "SkipSTBImage",
            .product(name: "SkipTest", package: "skip")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .target(name: "STBImage", sources: ["src"], cSettings: [
            .define("SKIP_BUILD_NDK") // needed for Skip to add native gradle build support
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .target(name: "SkipSTBTrueType", dependencies: [
            "STBTrueType",
            .product(name: "SkipFoundation", package: "skip-foundation"),
            .product(name: "SkipFFI", package: "skip-ffi")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .testTarget(name: "SkipSTBTrueTypeTests", dependencies: [
            "SkipSTBTrueType",
            .product(name: "SkipTest", package: "skip")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

        .target(name: "STBTrueType", sources: ["src"], cSettings: [
            .define("SKIP_BUILD_NDK") // needed for Skip to add native gradle build support
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),

    ]
)
