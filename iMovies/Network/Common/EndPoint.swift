//
//  EndPoint.swift
//  iMovies
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    static var baseUrl: String { get }
    var url: URL? { get }
}

/**
 * Internal struct for Url
 */
private struct Url {
    
    static let baseUrl: String = "http://api.themoviedb.org/3"
    static let apiKey: String = "e579f9a644180d2a8887223f0d0ad5ff"
    
    struct Fields {
        static let apiKey: String = "api_key"
        static let query: String = "query"
        static let page: String = "page"
    }
    
}

// MARK: - Search Endpoint
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .searchMovie(let movie, let page):
            guard let movieUrlFormat = movie.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return "/search/movie?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.page)=\(page)"
            }
            return "/search/movie?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.query)=\(movieUrlFormat)&\(Url.Fields.page)=\(page)"
        }
    }
    
    case searchMovie(movie: String, page: UInt)
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: Endpoint.baseUrl + self.rawValue)
        return urlComponents?.url
    }
    
    static var baseUrl: String {
        return Url.baseUrl
    }
}
