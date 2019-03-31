// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Identifier",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "Identifier", targets: ["Identifier"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.0")),
    ],
    targets: [
        .target(name: "Identifier"),
        .testTarget(name: "IdentifierTests", dependencies: ["Identifier", "Nimble"]),
    ],
    swiftLanguageVersions: [.v5]
)
