// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NikeNotifications",
    dependencies: [
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.2.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "NikeNotificationsLib",
            dependencies: ["SwiftyJSON", "SwiftSoup"]),
        .target(
            name: "NikeNotifications",
            dependencies: ["NikeNotificationsLib"]),
        .testTarget(
            name: "NikeNotificationsTests",
            dependencies: ["NikeNotificationsLib"]),
    ]
)
