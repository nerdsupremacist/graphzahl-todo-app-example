// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TodoAppServer",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "TodoAppServer",
                    targets: ["TodoAppServer"]),
    ],
    dependencies: [
        .package(url: "https://bitbucket.ase.in.tum.de/scm/mmq/leoql.git", .branch("master")),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0-beta."),
    ],
    targets: [
        .target(name: "TodoAppServer",
                dependencies: ["FluentLeo", "FluentSQLiteDriver"]),
    ]
)
