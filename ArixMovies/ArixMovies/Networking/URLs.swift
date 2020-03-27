//
//  URLs.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import Foundation

struct URLs {
    struct TMDB {
        static let base     = "https://api.themoviedb.org/"
        static let apiKey   = "api_key=128dbde77c7e613492b373569ad11fa3"
        struct paths {
            static let nowPlaying  = "/3/movie/now_playing"
            static let topRated    = "/3/movie/top_rated"
            static let genres      = "/3/genre/movie/list"
        }
    }
}
