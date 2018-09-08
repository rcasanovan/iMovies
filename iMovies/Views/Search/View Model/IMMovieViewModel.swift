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
    let largeUrlImage: URL?
    let title: String
    let releaseDate: String?
    let overview: String?
    let rating: Float
    
    /**
     * Internal struct for rating
     */
    private struct Rating {
        
        static let maxRealRating: Float = 10.0
        static let maxLocalRating: Float = 5.0
        
    }
    
    init(id: UInt, smallUrlImage: URL?, largeUrlImage: URL?, title: String, releaseDate: String?, overview: String?, rating: Float) {
        self.id = id
        self.smallUrlImage = smallUrlImage
        self.largeUrlImage = largeUrlImage
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.rating = rating
    }
    
    /**
     * Get the view models with a IMSingleMovieResponse array
     */
    public static func getViewModelsWith(movies: [IMSingleMovieResponse]) -> [IMMovieViewModel] {
        return movies.map { getViewModelWith(movie: $0) }
    }
    
    /**
     * Get a single view model with a IMSingleMovieResponse
     */
    public static func getViewModelWith(movie: IMSingleMovieResponse) -> IMMovieViewModel {
        let smallUrlImage = IMMovieImageManager.getSmalImageUrlWith(movie.poster_path)
        let largeUrlImage = IMMovieImageManager.getLargeImageUrlWith(movie.poster_path)
        // Get the release date with format
        let releaseDate = Date.getMMMddyyyyFormatWithStringDate(movie.release_date)
        // Get the local rating value (between 0 and 5)
        let rating = (movie.vote_average * Rating.maxLocalRating) / Rating.maxRealRating
        return IMMovieViewModel.init(id: movie.id, smallUrlImage: smallUrlImage, largeUrlImage: largeUrlImage, title: movie.title, releaseDate: releaseDate, overview: movie.overview, rating: rating)
    }

}
