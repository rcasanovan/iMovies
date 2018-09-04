//
//  IMMovieImagesTest.swift
//  iMoviesTests
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import iMovies

class IMMovieImagesTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetSmallImageUrl() {
        guard let smalImageUrl = IMMovieImageManager.getSmalImageUrlWith("/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg")  else {
            XCTFail("impossible to get the url")
            return
        }
        XCTAssertEqual("http://image.tmdb.org/t/p/w92/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg", smalImageUrl.absoluteString)
    }
    
    func testGetMediumImageUrl() {
        guard let smalImageUrl = IMMovieImageManager.getMediumImageUrlWith("/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg")  else {
            XCTFail("impossible to get the url")
            return
        }
        XCTAssertEqual("http://image.tmdb.org/t/p/w185/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg", smalImageUrl.absoluteString)
    }
    
    func testGetLargeImageUrl() {
        guard let smalImageUrl = IMMovieImageManager.getLargeImageUrlWith("/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg")  else {
            XCTFail("impossible to get the url")
            return
        }
        XCTAssertEqual("http://image.tmdb.org/t/p/w500/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg", smalImageUrl.absoluteString)
    }
    
}
