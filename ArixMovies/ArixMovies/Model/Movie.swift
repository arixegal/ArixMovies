//
//  Movie.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    // Decoded
    let title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let backdrop_path: String?
    let genre_ids: [Int]?
    
    // Computed
    var posterFullURL : URL?{
        return (poster_path == nil) ? nil : URL(string: "\(URLs.TMDB.posters)\(poster_path!)")
    }
}
