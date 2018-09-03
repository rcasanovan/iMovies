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

//enum Endpoint: String, EndpointProtocol {
//    case search = "/search"
//
//    // MARK: - Search Endpoint
//    enum searchMovie: EndpointProtocol {
//
//        var rawValue: String {
//            switch self {
//            case .search(let movie, let page):
//                return "search/movie?api_key=e579f9a644180d2a8887223f0d0ad5ff&quey=\(movie)&page=\(page)"
//            }
//        }
//
//        case search(movie: String, page: UInt)
//    }
//}

// MARK: - Search Endpoint
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .searchMovie(let movie, let page):
            guard let movieUrlFormat = movie.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return "/search/movie?api_key=e579f9a644180d2a8887223f0d0ad5ff&page=\(page)"
            }
            return "/search/movie?api_key=e579f9a644180d2a8887223f0d0ad5ff&query=\(movieUrlFormat)&page=\(page)"
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
        return "http://api.themoviedb.org/3"
    }
}
