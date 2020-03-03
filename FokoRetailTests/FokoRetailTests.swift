//
//  FokoRetailTests.swift
//  FokoRetailTests
//
//  Created by Rakesh Tripathi on 2020-02-27.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import XCTest
@testable import FokoRetail

class FokoRetailTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        TokenManager.teamId = 1
        TokenManager.playerId = 8476368

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            XCTAssert(TokenManager.teamId == 1)
            XCTAssert(TokenManager.playerId == 8476368)
        }
    }

}
