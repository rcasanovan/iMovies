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
    
    private var movies: [IMMovieViewModel]
    private var suggestions: [IMSuggestionViewModel] = [IMSuggestionViewModel]()
    
    init(view: IMSearchViewInjection) {
        self.view = view
        self.interactor = IMSearchInteractor()
        movies = [IMMovieViewModel]()
    }
    
}

extension IMSearchPresenter {
    
    private func getMoviesWithMovie(_ movie: String) {
        interactor.getMoviesWith(movie: movie) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let movies):
                guard let movies = movies?.results else {
                    return
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
    }
    
}

extension IMSearchPresenter: IMSearchPresenterDelegate {
    
    func viewDidLoad() {
        getMoviesWithMovie("batman")
    }
    
    func searchMovie(_ movie: String) {
        clearSearch()
        interactor.saveSearch(movie)
        getMoviesWithMovie(movie)
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
    
}
