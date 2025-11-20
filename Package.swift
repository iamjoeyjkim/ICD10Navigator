// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ICD10Navigator",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ICD10Navigator",
            targets: ["ICD10Navigator"]),
    ],
    targets: [
        .target(
            name: "ICD10Navigator",
            path: "ICD10Navigator"
        )
    ]
)
