//
//  APITests.swift
//  FokoRetailTests
//
//  Created by Rakesh Tripathi on 2020-03-02.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import XCTest
@testable import FokoRetail

class APITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //    func testExample() {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //    }
    //
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
    
    func testGetTeamsAPIMapping() {
        let asyncExpectation = expectation(description: "Async block executed")
        let getTeamsOp = MockGetTeamsAPI { (teams, error) in
//            DispatchQueue.main.async {
                XCTAssert(teams != nil)
            XCTAssert(teams?.copyright == "NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams. © NHL 2020. All Rights Reserved.")
                asyncExpectation.fulfill()
//            }
        }
        let operationQueue = OperationQueue()
        operationQueue.addOperation(getTeamsOp)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

