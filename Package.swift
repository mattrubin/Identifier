// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Identifier",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .tvOS(.v13),
        .visionOS(.v1),
        .watchOS(.v4),
    ],
    products: [
        .library(name: "Identifier", targets: ["Identifier"]),
    ],
    targets: [
        .target(name: "Identifier", exclude: ["Info.plist"]),
        .testTarget(name: "IdentifierTests", dependencies: ["Identifier"], exclude: ["Info.plist"]),
    ]
)
