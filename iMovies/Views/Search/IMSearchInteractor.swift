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
    
    func shouldGetMovies() -> Bool {
        if currentPage > totalPages {
            return false
        }
        
        return true
    }
    
    func clearSearch() {
        currentPage = 1
        totalPages = 1
    }
    
    func getMoviesWith(movie: String, completion: @escaping IMGetMoviesCompletionBlock) {
        var getMoviesRequest = IMGetMoviesRequest(movie: movie, page: currentPage)
        
        getMoviesRequest.completion = completion
        requestManager.send(request: getMoviesRequest)
    }
    
    func saveSearch(_ search: String) {
        IMSearchSuggestionsManager.saveSuggestion(search)
    }
    
    func getAllSuggestions(completion: @escaping IMGetSuggestionsCompletionBlock) {
        let suggestions = IMSearchSuggestionsManager.getSuggestions()
        completion(IMSuggestionViewModel.getViewModelsWith(suggestions: suggestions))
    }
    
    func updateResultResponse(_ response: IMMoviesResponse?) {
        guard let response = response else {
            return
        }
        
        currentPage = response.page + 1
        totalPages = response.total_pages
    }
    
}
