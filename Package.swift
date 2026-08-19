// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let isDevelopment = ProcessInfo.processInfo.environment["CHAOS_SWIFT_LIBRARY_DEVELOPMENT"] == "1"

let chaosLibDependencies: [Package.Dependency] = if isDevelopment {
    [.package(path: "../swift-chaos-math")]
} else {
    [.package(url: "https://github.com/chaosarts/swift-chaos-math.git", branch: "main")]
}

let package = Package(
    name: "ChaosSwiftUI",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ChaosSwiftUI",
            targets: ["ChaosSwiftUI"],
        ),
    ],
    dependencies: chaosLibDependencies + [
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", .upToNextMajor(from: "0.65.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ChaosSwiftUI",
            dependencies: [
                .product(name: "ChaosMath", package: "swift-chaos-math"),
            ],
            swiftSettings: [.enableUpcomingFeature("MemberImportVisibility")],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins"),
            ],
        ),
        .testTarget(
            name: "ChaosSwiftUITests",
            dependencies: ["ChaosSwiftUI"],
        ),
    ],
    swiftLanguageModes: [.v6],
)
