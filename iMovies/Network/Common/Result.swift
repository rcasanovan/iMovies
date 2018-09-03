//
//  Result.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ResultError)
}
