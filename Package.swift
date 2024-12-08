// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Identifier",
    platforms: [
        .iOS(.v15),
        .macOS(.v11),
        .tvOS(.v15),
        .visionOS(.v1),
        .watchOS(.v8),
    ],
    products: [
        .library(name: "Identifier", targets: ["Identifier"]),
    ],
    targets: [
        .target(name: "Identifier", exclude: ["Info.plist"]),
        .testTarget(name: "IdentifierTests", dependencies: ["Identifier"], exclude: ["Info.plist"]),
    ]
)
