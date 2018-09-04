//
//  IMNetworkTests.swift
//  iMoviesTests
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import iMovies

class IMNetworkTests: XCTestCase {
    
    private let requestManager = RequestManager()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetMoviesWith(movie: String, page: UInt, completion: @escaping IMGetMoviesCompletionBlock) {
        var getMoviesRequest = IMGetMoviesRequest(movie: movie, page: page)
        
        getMoviesRequest.completion = completion
        requestManager.send(request: getMoviesRequest)
    }
    
    func testGetMovie(movie: String) {
        let moviesExpectation: XCTestExpectation = self.expectation(description: "movies")
        
        testGetMoviesWith(movie: movie, page: 1) { (response) in
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
    
    func testGetBatmanMovies() {
        testGetMovie(movie: "Batman")
    }
    
    func testGetSupermanMovies() {
        testGetMovie(movie: "superman")
    }
    
    func testGetStarWarsMovies() {
        testGetMovie(movie: "Star Wars")
    }
    
    func testGetTheLordOfTheRingsMovies() {
        testGetMovie(movie: "The Lord of the Rings")
    }
    
    func testGetBackToTheFutureMovies() {
        testGetMovie(movie: "back to the future")
    }
    
    func testGetBackToTheFutureWithWhitespacesMovies() {
        testGetMovie(movie: "back   to   the    future")
    }
    
}
