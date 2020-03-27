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
    var fetchedMoviePages : [[Movie]]?
    let numberOfPagesToFetch : Int
    
    init(configuration: URLSessionConfiguration, numberOfPagesToFetch:Int) {
        self.session = URLSession(configuration: configuration)
        self.numberOfPagesToFetch = numberOfPagesToFetch
        self.fetchedMoviePages = [Int](1...numberOfPagesToFetch).compactMap{_ in
            []
        }
    }
    
    convenience init() {
        self.init(configuration: .default, numberOfPagesToFetch: 5)
    }
    
    func getMovies(page: Int, completion: @escaping (Result<MovieFeedResult?, APIError>) -> Void)
    {
        guard page > 0 else{
            completion(Result.failure(APIError.internalInconsistency))
            return
        }
        fetch(BaseUrlString: URLs.TMDB.base, path: URLs.TMDB.paths.popular, queryItems: ["page":"\(page)"], decode: { json -> MovieFeedResult? in
            guard let moviesResult = json as? MovieFeedResult else {return  nil}
            return moviesResult
        }, completion: completion)
    }
    
    func getAllMoviePages()
    {
        [Int](1...numberOfPagesToFetch).forEach {
            getMovies(page: $0) { result in
                print(result)
            }
        }
    }
}
