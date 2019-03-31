// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Identifier",
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
