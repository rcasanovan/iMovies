//
//  IMMovieResponse.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

struct IMMovieResponse: Decodable {
    let id: UInt
    let poster_path: String
    let title: String
}
