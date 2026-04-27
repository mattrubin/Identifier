// SPDX-FileCopyrightText: © 2019-2026 Matt Rubin
// SPDX-License-Identifier: MIT
// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Identifier",
    products: [
        .library(name: "Identifier", targets: ["Identifier"]),
    ],
    targets: [
        .target(name: "Identifier"),
        .testTarget(name: "IdentifierTests", dependencies: ["Identifier"]),
    ]
)
