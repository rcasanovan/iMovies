//
//  IMNetworkTests.swift
//  iMoviesTests
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import iMovies

typealias IMGetTestMoviesCompletionBlock = (Result<IMMoviesResponse?>) -> Void

class IMNetworkTests: XCTestCase {
    
    private let requestManager = RequestManager()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func getMoviesWith(movie: String, page: UInt, completion: @escaping IMGetTestMoviesCompletionBlock) {
        var getMoviesRequest = IMGetMoviesRequest(movie: movie, page: page)
        
        getMoviesRequest.completion = completion
        requestManager.send(request: getMoviesRequest)
    }
    
    func testGetBatmanMovies() {
        let moviesExpectation: XCTestExpectation = self.expectation(description: "movies")
        
        getMoviesWith(movie: "batman", page: 1) { (response) in
            switch response {
            case .success(let movies):
                guard let count = movies?.results.count else {
                    XCTFail("impossible to get the total number of movies related")
                    return
                }
                
                XCTAssertTrue(count > 0, "We're not movies releated. Really?")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            
            moviesExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testGetSupermanMovies() {
        let moviesExpectation: XCTestExpectation = self.expectation(description: "movies")
        
        getMoviesWith(movie: "superman", page: 1) { (response) in
            switch response {
            case .success(let movies):
                guard let count = movies?.results.count else {
                    XCTFail("impossible to get the total number of movies related")
                    return
                }
                
                XCTAssertTrue(count > 0, "We're not movies releated. Really?")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            
            moviesExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testGetBackToTheFuturenMovies() {
        let moviesExpectation: XCTestExpectation = self.expectation(description: "movies")
        
        getMoviesWith(movie: "back to the future", page: 1) { (response) in
            switch response {
            case .success(let movies):
                guard let count = movies?.results.count else {
                    XCTFail("impossible to get the total number of movies related")
                    return
                }
                
                XCTAssertTrue(count > 0, "We're not movies releated. Really?")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            
            moviesExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 20.0, handler: nil)
    }
    
}
