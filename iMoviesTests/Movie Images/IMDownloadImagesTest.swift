//
//  IMDownloadImagesTest.swift
//  iMoviesTests
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import iMovies

class IMDownloadImagesTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDownloadImageWithUrl(_ url: URL?) {
        let getImageExpectation: XCTestExpectation = self.expectation(description: "image")
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
        guard let url = url else {
            XCTFail("impossible to get the url")
            return
        }
        imageView.hnk_setImage(from: url, placeholder: nil, success: { (image) in
            XCTAssertNotNil(image)
            getImageExpectation.fulfill()
        }) { (error) in
            XCTFail("something went wrong getting the image from the url")
        }
        
        self.waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testDownloadTMDBSmallImage() {
        let url = IMMovieImageManager.getSmalImageUrlWith("/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg")
        testDownloadImageWithUrl(url)
    }
    
    func testDownloadTMDBMediumImage() {
        let url = IMMovieImageManager.getMediumImageUrlWith("/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg")
        testDownloadImageWithUrl(url)
    }
    
    func testDownloadTMDBLargeImage() {
        let url = IMMovieImageManager.getLargeImageUrlWith("/pTpxQB1N0waaSc3OSn0e9oc8kx9.jpg")
        testDownloadImageWithUrl(url)
    }
    
}
