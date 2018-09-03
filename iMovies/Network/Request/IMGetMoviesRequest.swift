//
//  IMGetMoviesRequest.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

struct IMGetMoviesRequest: RequestProtocol {
    typealias ResponseType = [IMMovieResponse]
    var completion: ((Result<[IMMovieResponse]?>) -> Void)?
    var method: HTTPMethod = .get
    var url: URL? = nil
    var encodableBody: Encodable? = nil
    
    init(movie: String, page: UInt) {
        url = Endpoint.searchMovie(movie: movie, page: page).url
    }
}
