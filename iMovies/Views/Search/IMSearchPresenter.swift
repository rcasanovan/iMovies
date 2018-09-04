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
    
}

extension IMSearchPresenter: IMSearchPresenterDelegate {
    
    func viewDidLoad() {
        getMoviesWithMovie("star wars")
    }
    
}
