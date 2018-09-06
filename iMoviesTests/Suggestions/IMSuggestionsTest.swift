//
//  IMSuggestionsTest.swift
//  iMoviesTests
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import XCTest
@testable import iMovies

class IMSuggestionsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeleteAllSuggestions() {
        IMSearchSuggestionsManager.saveSuggestion("superman")
        IMSearchSuggestionsManager.saveSuggestion("back to the future")
        IMSearchSuggestionsManager.deleteAllSuggestions()
        
        let suggestions = IMSearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions.count == 0)
    }
    
    func testSaveSuggestions() {
        IMSearchSuggestionsManager.deleteAllSuggestions()
        
        IMSearchSuggestionsManager.saveSuggestion("batman")
        IMSearchSuggestionsManager.saveSuggestion("superman")
        IMSearchSuggestionsManager.saveSuggestion("back to the future")
        
        let suggestions = IMSearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions.count == 3)
    }
    
    func testOrderSuggestions() {
        IMSearchSuggestionsManager.deleteAllSuggestions()
        
        IMSearchSuggestionsManager.saveSuggestion("batman")
        IMSearchSuggestionsManager.saveSuggestion("superman")
        IMSearchSuggestionsManager.saveSuggestion("back to the future")
        
        let suggestions = IMSearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions[0].suggestion == "back to the future" &&
            suggestions[1].suggestion == "superman" &&
            suggestions[2].suggestion == "batman")
    }
    
    func testOnlyMaintainFirstSuggestions() {
        IMSearchSuggestionsManager.deleteAllSuggestions()
        
        IMSearchSuggestionsManager.saveSuggestion("batman")
        IMSearchSuggestionsManager.saveSuggestion("superman")
        IMSearchSuggestionsManager.saveSuggestion("back to the future")
        IMSearchSuggestionsManager.saveSuggestion("the lord of the rings")
        IMSearchSuggestionsManager.saveSuggestion("lego")
        IMSearchSuggestionsManager.saveSuggestion("joker")
        IMSearchSuggestionsManager.saveSuggestion("the pianist")
        IMSearchSuggestionsManager.saveSuggestion("time")
        IMSearchSuggestionsManager.saveSuggestion("ghost")
        IMSearchSuggestionsManager.saveSuggestion("guardians of the galaxy")
        
        IMSearchSuggestionsManager.saveSuggestion("iron man")
        
        let suggestions = IMSearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions.count == 10, "Max number of suggestions should be 10")
    }
    
    func testMovieExists() {
        IMSearchSuggestionsManager.deleteAllSuggestions()
        
        IMSearchSuggestionsManager.saveSuggestion("batman")
        IMSearchSuggestionsManager.saveSuggestion("superman")
        IMSearchSuggestionsManager.saveSuggestion("back to the future")
        IMSearchSuggestionsManager.saveSuggestion("the lord of the rings")
        IMSearchSuggestionsManager.saveSuggestion("lego")
        IMSearchSuggestionsManager.saveSuggestion("joker")
        
        let suggestionExists = IMSearchSuggestionsManager.suggestionExists("superman")
        XCTAssert(suggestionExists == true, "The suggestion doesn't exist in the data base")
    }
    
}
