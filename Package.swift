// swift-tools-version:4.0
import PackageDescription


let package = Package(
    name: "OutlawUIKit",
    products: [
        .library(name: "OutlawUIKit", targets: ["OutlawUIKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Molbie/Outlaw.git", from: "4.0.0"),
        .package(url: "https://github.com/Molbie/Outlaw-CoreGraphics.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "OutlawUIKit", dependencies: ["Outlaw", "OutlawCoreGraphics"]),
        .testTarget(name: "OutlawUIKitTests", dependencies: ["OutlawUIKit"])
    ]
)
