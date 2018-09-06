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
        movies = [IMMovieViewModel]()
    }
    
}

extension IMSearchPresenter {
    
    private func getMoviesWithMovie(_ movie: String, showProgress: Bool) {
        if !interactor.shouldGetMovies() { return }
        
        view?.showProgress(showProgress)
        interactor.getMoviesWith(movie: movie) { [weak self] (response) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            switch response {
            case .success(let movies):
                self.interactor.updateResultResponse(movies)
                
                guard let movies = movies?.results else {
                    return
                }
                if !movies.isEmpty {
                    self.interactor.saveSearch(movie)
                }
                self.movies.append(contentsOf: IMMovieViewModel.getViewModelsWith(movies: movies))
                self.view?.loadMovies(self.movies)
                break
            case .failure(_):
                print("failure")
                break
            }
        }
    }
    
    private func clearSearch() {
        movies = []
        interactor.clearSearch()
    }
    
}

extension IMSearchPresenter: IMSearchPresenterDelegate {
    
    func searchMovie(_ movie: String) {
        if movie.isEmptyOrWhitespace() {
            print("TODO: Show an alert box")
            return
        }
        
        self.movie = movie.condenseWhitespaces()
        clearSearch()
        getMoviesWithMovie(movie, showProgress: true)
    }
    
    func getSuggestions() {
        interactor.getAllSuggestions { [weak self] (suggestions) in
            guard let `self` = self else { return }
            self.suggestions = suggestions
            self.view?.loadSuggestions(self.suggestions)
        }
    }
    
    func suggestionSelectedAt(index: NSInteger) {
        if index < 0 || index >= suggestions.count {
            return
        }
        let suggestion = self.suggestions[index]
        searchMovie(suggestion.suggestion)
    }
    
    func loadNextPage() {
        guard let movie = movie else { return }
        getMoviesWithMovie(movie, showProgress: false)
    }
    
}
