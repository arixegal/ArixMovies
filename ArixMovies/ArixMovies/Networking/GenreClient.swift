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
    var fetchedResult : GenresResult?

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchAllGenres(completion:(()->Void)?)
    {
        getGenresNetAPI {[weak self] result in
            switch result {
            case .success(let genresResult):
                self?.fetchedResult = genresResult
            case .failure(let error):
                print("the error \(error)")
            }
            completion?()
        }
    }

    
    func getGenresNetAPI(completion: @escaping (Result<GenresResult?, APIError>) -> Void) {
        
        fetch(BaseUrlString: URLs.TMDB.base, path: URLs.TMDB.paths.genres, queryItems: [:], decode: { json -> GenresResult? in
            guard let genresResult = json as? GenresResult else {return  nil}
            return genresResult
        }, completion: completion)
    }
}
