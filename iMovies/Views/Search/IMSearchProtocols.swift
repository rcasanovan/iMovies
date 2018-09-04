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
    func loadMovies(_ movies: [IMMovieViewModel])
}

protocol IMSearchPresenterDelegate : class {
    func viewDidLoad()
    func searchMovie(_ movie: String)
}

// Presenter / Interactor

typealias IMGetMoviesCompletionBlock = (Result<IMMoviesResponse?>) -> Void

protocol IMSearchInteractorDelegate : class {
    func getMoviesWith(movie: String, completion: @escaping IMGetMoviesCompletionBlock)
}
