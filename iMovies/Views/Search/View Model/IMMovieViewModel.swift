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
    let mediumUrlImage: URL?
    let largeUrlImage: URL?
    let title: String
    
    init(id: UInt, smallUrlImage: URL?, mediumUrlImage: URL?, largeUrlImage: URL?, title: String) {
        self.id = id
        self.smallUrlImage = smallUrlImage
        self.mediumUrlImage = mediumUrlImage
        self.largeUrlImage = largeUrlImage
        self.title = title
    }
    
    public static func getViewModelsWith(movies: [IMSingleMovieResponse]) -> [IMMovieViewModel] {
        return movies.map { getViewModelWith(movie: $0) }
    }
    
    public static func getViewModelWith(movie: IMSingleMovieResponse) -> IMMovieViewModel {
        let smallUrlImage = IMMovieImageManager.getSmalImageUrlWith(movie.poster_path)
        let mediumUrlImage = IMMovieImageManager.getMediumImageUrlWith(movie.poster_path)
        let largeUrlImage = IMMovieImageManager.getLargeImageUrlWith(movie.poster_path)
        return IMMovieViewModel.init(id: movie.id, smallUrlImage: smallUrlImage, mediumUrlImage: mediumUrlImage, largeUrlImage: largeUrlImage, title: movie.title)
    }
}