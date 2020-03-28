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
    
    var releaseDateForDisplay : String{
        guard let dateString = release_date else {return ""}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        guard let date = formatter.date(from: dateString) else {return ""}
        formatter.dateStyle = .full
        return "Released on \(formatter.string(from: date))"
    }
    
    var shouldBeHighlighted : Bool {
        guard let userSelectedGenreID = MovieClient.userSelectedGenreId else {return false}
        guard let myGenreIDs = genre_ids else {return false}
        return myGenreIDs.contains(userSelectedGenreID)
    }
}
