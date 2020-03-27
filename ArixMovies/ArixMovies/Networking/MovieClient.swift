//
//  MovieClient.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import Foundation

class MovieClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    

    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getGenres(completion: @escaping (Result<GenresResult?, APIError>) -> Void) {
        
        fetch(BaseUrlString: URLs.TMDB.base, path: URLs.TMDB.paths.genres, queryItems: [:], decode: { json -> GenresResult? in
            guard let movieFeedResult = json as? GenresResult else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}





