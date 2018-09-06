//
//  IMStringTest.swift
//  iMoviesTests
//
//  Created by Ricardo Casanova on 06/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import iMovies

class IMStringTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStringWithOnlyWhitespaces() {
        let string = "               "
        XCTAssert(string.isEmptyOrWhitespace() == true)
    }
    
    func testStringIsEmpty() {
        let string = ""
        XCTAssert(string.isEmptyOrWhitespace() == true)
    }
    
    func testStringCondensedWhitespaces() {
        let string = "Iron        man         3       "
        XCTAssert(string.condenseWhitespaces() == "Iron man 3")
    }
    
}
