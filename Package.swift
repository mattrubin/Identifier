// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Identifier",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "Identifier", targets: ["Identifier"]),
    ],
    targets: [
        .target(name: "Identifier"),
        .testTarget(name: "IdentifierTests", dependencies: ["Identifier"]),
    ],
    swiftLanguageVersions: [.v5]
)
