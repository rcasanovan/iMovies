//
//  IMSearchPresenter.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSearchPresenter {
    
    private weak var view: IMSearchViewInjection?
    private let interactor: IMSearchInteractorDelegate
    
    private var movie: String?
    private var movies: [IMMovieViewModel]
    private var suggestions: [IMSuggestionViewModel] = [IMSuggestionViewModel]()
    
    init(view: IMSearchViewInjection) {
        self.view = view
        self.interactor = IMSearchInteractor()
        self.movies = [IMMovieViewModel]()
    }
    
}

// MARK: - Private section
extension IMSearchPresenter {
    
    /**
     * Get the movies resuls
     *
     * - parameters:
     *      -movie: movie to search
     *      -showProgress: show the progress or not
     */
    private func getMoviesWithMovie(_ movie: String, showProgress: Bool) {
        // Couldn't we have movies? -> return
        if !interactor.shouldGetMovies() { return }
        
        view?.showProgress(showProgress)
        interactor.getMoviesWith(movie: movie) { [weak self] (response) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            switch response {
            case .success(let movies):
                // If we get the movies -> process the results
                self.processMoviesResults(movieSearch: movie, movies: movies, showProgress: showProgress)
                break
            case .failure(_):
                print("failure")
                break
            }
        }
    }
    
    /**
     * Process the result for movies
     *
     * - parameters:
     *      -movieSearch: movie to search
     *      -movies: movies response
     *      -showProgress: show progress or not
     */
    private func processMoviesResults(movieSearch: String, movies: IMMoviesResponse?, showProgress: Bool) {
        // Update the result response
        interactor.updateResultResponse(movies)
        
        guard let totalResults = movies?.total_results, let movies = movies?.results else {
            return
        }
        
        if !movies.isEmpty {
            // Save the movie search
            interactor.saveSearch(movieSearch)
        }
        else {
            view?.showMessageWith(title: "Oops", message: "It seems we don't have that movie in the catalog right now 😢. Please try again", actionTitle: "Accept")
        }
        
        self.movies.append(contentsOf: IMMovieViewModel.getViewModelsWith(movies: movies))
        // Load the movies in the view
        view?.loadMovies(self.movies, fromBeginning: showProgress, totalResults: totalResults)
    }
    
    /**
     * Clear the current search state
     */
    private func clearSearch() {
        // Clear the movies
        movies = []
        // Clear the interactor search logic
        interactor.clearSearch()
    }
    
}

// MARK: - IMSearchPresenterDelegate
extension IMSearchPresenter: IMSearchPresenterDelegate {
    
    /**
     * Search movie
     *
     * - parameters:
     *      -movie: movie to search
    */
    func searchMovie(_ movie: String) {
        // If the movie is completely empty or only contains whitespaces -> show an error message
        if movie.isEmptyOrWhitespace() {
            view?.showMessageWith(title: "Oops ✋🤚", message: "It looks you´re trying to search a movie using a invalid criteria. Please try again", actionTitle: "Accept")
            return
        }
        
        // Remove double whitespaces
        self.movie = movie.condenseWhitespaces()
        // Clear the current search
        clearSearch()
        // Get the movies && show the progress
        getMoviesWithMovie(movie, showProgress: true)
    }
    
    /**
     * Get all suggestions
     */
    func getSuggestions() {
        interactor.getAllSuggestions { [weak self] (suggestions) in
            guard let `self` = self else { return }
            self.suggestions = suggestions
            self.view?.loadSuggestions(self.suggestions)
        }
    }
    
    /**
     * The user selected a suggestion
     *
     * - parameters:
     *      -index: selected index
     */
    func suggestionSelectedAt(index: NSInteger) {
        // If the index is out of bounds -> do nothing
        if index < 0 || index >= suggestions.count {
            return
        }
        // Get the selected suggestion
        let suggestion = self.suggestions[index]
        // Search movie with the suggestion
        searchMovie(suggestion.suggestion)
    }
    
    /**
     * Load the next page for the current search
     */
    func loadNextPage() {
        guard let movie = movie else { return }
        getMoviesWithMovie(movie, showProgress: false)
    }
    
}
