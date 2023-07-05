//
//  GLTFKit2Tests.swift
//  
//
//  Created by Softsphere on 4.07.23.
//

import Foundation
import XCTest
import GLTFKit2

class GLTFKit2Tests: XCTestCase {
    func testLoadingFromURL() throws {
        let modelUrl = try XCTUnwrap(Bundle.module.url(forResource: "Lantern", withExtension: "glb"))
        let asset = try GLTFAsset(url: modelUrl)
        XCTAssertEqual(asset.nodes.count, 4)
    }
    
    func testLoadingFromData() throws {
        let modelUrl = try XCTUnwrap(Bundle.module.url(forResource: "Lantern", withExtension: "glb"))
        let modelData = try Data(contentsOf: modelUrl)
        let asset = try GLTFAsset(data: modelData)
        XCTAssertEqual(asset.nodes.count, 4)
    }
}
