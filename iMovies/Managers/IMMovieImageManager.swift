//
//  IMMovieImageManager.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMMovieImageManager {
    
    private struct Url {
        static let host: String = "image.tmdb.org"
        static let path = "/t/p/"
        
        struct ImageSize {
            static let small: String = "w92"
            static let medium: String = "w185"
            static let large: String = "w500"
        }
    }
    
    public static func getSmalImageUrlWith(_ partialUrl: String?) -> URL? {
        guard let partialUrl = partialUrl else {
            return nil
        }
        
        var components = getURLComponents()
        components.path = Url.path + Url.ImageSize.small + partialUrl
        return components.url
    }
    
    public static func getMediumImageUrlWith(_ partialUrl: String?) -> URL? {
        guard let partialUrl = partialUrl else {
            return nil
        }
        
        var components = getURLComponents()
        components.path = Url.path + Url.ImageSize.medium + partialUrl
        return components.url
    }
    
    public static func getLargeImageUrlWith(_ partialUrl: String?) -> URL? {
        guard let partialUrl = partialUrl else {
            return nil
        }
        
        var components = getURLComponents()
        components.path = Url.path + Url.ImageSize.large + partialUrl
        return components.url
    }
    
}

extension IMMovieImageManager {
    
    private static func getURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = Url.host
        return components
    }
    
}
