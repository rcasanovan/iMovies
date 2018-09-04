//
//  IMSearchInteractor.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSearchInteractor {
    
    private var page: UInt
    private let requestManager: RequestManager
    
    init() {
        self.page = 1
        self.requestManager = RequestManager()
    }
}

extension IMSearchInteractor: IMSearchInteractorDelegate {
    
    func getMoviesWith(movie: String, completion: @escaping IMGetMoviesCompletionBlock) {
        var getMoviesRequest = IMGetMoviesRequest(movie: movie, page: page)
        
        getMoviesRequest.completion = completion
        requestManager.send(request: getMoviesRequest)
    }
    
}
