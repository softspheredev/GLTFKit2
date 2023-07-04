//
//  GLTFKit2RealityKitTests.swift
//  
//
//  Created by Softsphere on 4.07.23.
//

import Foundation
import XCTest
import GLTFKit2
import GLTFRealityKit
import RealityKit

class GLTFRealityKitTests: XCTestCase {
    @MainActor static func render(resource name: String, zOffset: Float) async throws -> Data? {
        return try await withCheckedThrowingContinuation { continuation in
            let arView = ARView(
                frame: .init(
                    origin: .zero,
                    size: .init(width: 800, height: 800)
                )
            )
            let modelUrl = try! XCTUnwrap(Bundle.module.url(forResource: name, withExtension: "glb"))
            let asset = try! GLTFAsset(url: modelUrl)
            let scene = try! XCTUnwrap(asset.scenes.first)
            let entity = GLTFRealityKitLoader.convert(scene: scene)
            let anchor = AnchorEntity(world: [0, 0, zOffset])
            anchor.addChild(entity)
            arView.scene.addAnchor(anchor)
            arView.snapshot(saveToHDR: false) {
                continuation.resume(returning: $0?.tiffRepresentation)
            }
        }
    }
    
    static func testRsource(name: String, zOffset: Float) async throws {
        let image = try await GLTFRealityKitTests.render(resource: name, zOffset: zOffset)
        let expectationUrl = try XCTUnwrap(Bundle.module.url(forResource: name, withExtension: "jpg"))
        let expectation = try Data(contentsOf: expectationUrl)
        XCTAssertEqual(image, expectation)
    }
    
    func testDamagedHelmet() async throws {
        try await GLTFRealityKitTests.testRsource(
            name: "DamagedHelmet",
            zOffset: -1
        )
    }
    
    func testClearCoat() async throws {
        try await GLTFRealityKitTests.testRsource(
            name: "ClearCoatTest",
            zOffset: -16
        )
    }
    
    func testAlphaBlendMode() async throws {
        try await GLTFRealityKitTests.testRsource(
            name: "AlphaBlendModeTest",
            zOffset: -8
        )
    }
}
