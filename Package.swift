// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GLTFKit2",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        .library(name: "GLTFKit2", targets: ["GLTFKit2"]),
        .library(name: "GLTFRealityKit", targets: ["GLTFRealityKit"])
    ],
    targets: [
        .target(
            name: "GLTFKit2",
            dependencies: [],
            resources: [
                .copy("Shaders/WorkflowShaders.txt")
            ],
            publicHeadersPath: "Headers"
        ),
        .target(
            name: "GLTFRealityKit",
            dependencies: ["GLTFKit2"]
        ),
        .testTarget(
            name: "GLTFKit2Tests",
            dependencies: ["GLTFKit2"],
            resources: [
                .copy("Lantern.glb")
            ]
        ),
        .testTarget(
            name: "GLTFRealityKitTests",
            dependencies: ["GLTFRealityKit"],
            resources: [
                .copy("Assets/ClearCoatTest.glb"),
                .copy("Assets/AlphaBlendModeTest.glb"),
                .copy("Assets/DamagedHelmet.glb"),
                .copy("Expectations/ClearCoatTest.jpg"),
                .copy("Expectations/AlphaBlendModeTest.jpg"),
                .copy("Expectations/DamagedHelmet.jpg")
            ]
        )
    ]
)
