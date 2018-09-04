//
//  IMMoviesResponse.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

struct IMMoviesResponse: Decodable {
    let page: UInt
    let total_results: UInt
    let total_pages: UInt
    let results: [IMSingleMovieResponse]
}

struct IMSingleMovieResponse: Decodable {
    let id: UInt
    let vote_average: Float
    let poster_path: String?
    let title: String
    let overview: String?
}
