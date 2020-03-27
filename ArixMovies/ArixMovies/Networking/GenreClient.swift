//
//  GenreClient.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import UIKit

class GenreClient: APIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getGenres(completion: @escaping (Result<GenresResult?, APIError>) -> Void) {
        
        fetch(BaseUrlString: URLs.TMDB.base, path: URLs.TMDB.paths.genres, queryItems: [:], decode: { json -> GenresResult? in
            guard let genresResult = json as? GenresResult else {return  nil}
            return genresResult
        }, completion: completion)
    }
}
