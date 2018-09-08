//
//  IMSearchInteractor.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSearchInteractor {
    
    private var currentPage: UInt
    private var totalPages: UInt
    private let requestManager: RequestManager
    
    init() {
        self.currentPage = 1
        self.totalPages = 1
        self.requestManager = RequestManager()
    }
}

extension IMSearchInteractor: IMSearchInteractorDelegate {
    
    /**
     * Determinate if we can request movies or not
     */
    func shouldGetMovies() -> Bool {
        // If the current page > total pages -> we loaded all the pages. Return false
        if currentPage > totalPages {
            return false
        }
        
        // Otherwise we can request more movies
        return true
    }
    
    /**
     * Clear the current search
     */
    func clearSearch() {
        // Current page = 1 again and total pages = 1
        currentPage = 1
        totalPages = 1
    }
    
    /**
     * Get the movies resuls
     *
     * - parameters:
     *      -movie: movie to search
     *      -completion: completion block
     */
    func getMoviesWith(movie: String, completion: @escaping IMGetMoviesCompletionBlock) {
        // Create the get movie request
        var getMoviesRequest = IMGetMoviesRequest(movie: movie, page: currentPage)
        
        // Add the competion
        getMoviesRequest.completion = completion
        // Send the request
        requestManager.send(request: getMoviesRequest)
    }
    
    /**
     * Save the current search
     *
     * - parameters:
     *      -search: movie search to save
     */
    func saveSearch(_ search: String) {
        IMSearchSuggestionsManager.saveSuggestion(search)
    }
    
    /**
     * Get all suggestions
     *
     * - parameters:
     *      -completion: completion block
     */
    func getAllSuggestions(completion: @escaping IMGetSuggestionsCompletionBlock) {
        let suggestions = IMSearchSuggestionsManager.getSuggestions()
        completion(IMSuggestionViewModel.getViewModelsWith(suggestions: suggestions))
    }
    
    /**
     * Update result response
     *
     * - parameters:
     *      -response: response to update
     */
    func updateResultResponse(_ response: IMMoviesResponse?) {
        guard let response = response else {
            return
        }
        
        // Increase the current page
        currentPage = response.page + 1
        // Set the total pages
        totalPages = response.total_pages
    }
    
}
