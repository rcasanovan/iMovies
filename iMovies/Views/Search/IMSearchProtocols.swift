//
//  IMSearchProtocols.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

// View / Presenter
protocol IMSearchViewInjection : class {
    func loadMovies(_ movies: [IMMovieViewModel], fromBeginning: Bool, totalResults: UInt)
    func loadSuggestions(_ suggestions: [IMSuggestionViewModel])
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol IMSearchPresenterDelegate : class {
    func searchMovie(_ movie: String)
    func loadNextPage()
    func getSuggestions()
    func suggestionSelectedAt(index: NSInteger)
    func reachabilityStatusChanged()
}

// Presenter / Interactor

typealias IMGetMoviesCompletionBlock = (Result<IMMoviesResponse?>) -> Void
typealias IMGetSuggestionsCompletionBlock = ([IMSuggestionViewModel]) -> Void

protocol IMSearchInteractorDelegate : class {
    func shouldGetMovies() -> Bool
    func clearSearch()
    func getMoviesWith(movie: String, completion: @escaping IMGetMoviesCompletionBlock)
    func saveSearch(_ search: String)
    func getAllSuggestions(completion: @escaping IMGetSuggestionsCompletionBlock)
    func updateResultResponse(_ response: IMMoviesResponse?)
}

// Presenter / Router

protocol IMSearchRouterDelegate : class {
    func showReachabilityStatus(show: Bool)
}
