//
//  Endpoint.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var apiKey: String {
        return URLs.TMDB.apiKey
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum MovieFeed {
    
    case nowPlaying
    case topRated
}

extension MovieFeed: Endpoint {
    
    var base: String {
        return URLs.TMDB.base
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return URLs.TMDB.paths.nowPlaying
        case .topRated: return URLs.TMDB.paths.topRated
        }
    }
}

struct GenresFeed : Endpoint{
    var base: String {
        return URLs.TMDB.base
    }
    
    var path: String {
        return URLs.TMDB.paths.genres
    }
}






