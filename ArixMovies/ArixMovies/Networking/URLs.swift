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
        static let base     = "https://api.themoviedb.org"
        static let apiKey   = "128dbde77c7e613492b373569ad11fa3"
        static let posters  = "https://image.tmdb.org/t/p/w92" // Should be fetched from the /configuration api
        struct paths {
            static let popular     = "/3/movie/popular"
            static let genres      = "/3/genre/movie/list"
        }
    }
}
