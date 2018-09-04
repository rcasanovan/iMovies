//
//  IMMovieViewModel.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

struct IMMovieViewModel {
    
    let id: UInt
    let smallUrlImage: URL?
    let title: String
    
    init(id: UInt, smallUrlImage: URL?, title: String) {
        self.id = id
        self.smallUrlImage = smallUrlImage
        self.title = title
    }
    
    public static func getViewModelsWith(movies: [IMSingleMovieResponse]) -> [IMMovieViewModel] {
        return movies.map { getViewModelWith(movie: $0) }
    }
    
    public static func getViewModelWith(movie: IMSingleMovieResponse) -> IMMovieViewModel {
        let smallUrlImage = IMMovieImageManager.getSmalImageUrlWith(movie.poster_path)
        return IMMovieViewModel.init(id: movie.id, smallUrlImage: smallUrlImage, title: movie.title)
    }
}
