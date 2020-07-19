//
//  mytestTests.swift
//  mytestTests
//
//  Created by knuproimac on 2020-07-17.
//  Copyright © 2020 tony. All rights reserved.
//
var sut: ModelMenuGroup!

import XCTest
@testable import mytest

class mytestTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        sut = ModelMenuGroup()
       
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testMenuAClass() throws{
        let newiD:Int? = sut.groupID
        sut.onlyForTest(newiD)
        XCTAssertEqual(sut.groupID, 100, "The number is wrong")
    }
}
