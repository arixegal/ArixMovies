//
//  MovieClient.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import Foundation

protocol MoviesClientDelegate : class
{
    func allPagesFetched()
}

class MovieClient: APIClient {
    
    let session: URLSession
    var fetchedMoviePages : [[Movie]?]
    let numberOfPagesToFetch : Int
    weak var delegate : MoviesClientDelegate?{
        didSet{
            if allFetched(){
                delegate?.allPagesFetched()
            }
        }
    }
    let barrierQueue = DispatchQueue(label: "Home.ArikSegal.ArixMovies.Paging", attributes: .concurrent)
    var combinedResults : [Movie]{
        return fetchedMoviePages.compactMap{$0}.flatMap{$0}
    }
    var userSelectedGenreId : Int?
    
    init(configuration: URLSessionConfiguration, numberOfPagesToFetch:Int, delegate: MoviesClientDelegate?) {
        self.session = URLSession(configuration: configuration)
        self.numberOfPagesToFetch = numberOfPagesToFetch
        self.delegate = delegate
        self.fetchedMoviePages = [Int](1...numberOfPagesToFetch).map{_ in
            nil
        }
    }
    
    convenience init(delegate : MoviesClientDelegate?) {
        self.init(configuration: .default, numberOfPagesToFetch: 5, delegate:delegate)
    }
    
    func getMoviesNetAPI(page: Int, completion: @escaping (Result<MovieFeedResult?, APIError>) -> Void)
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
            let page = $0
            getMoviesNetAPI(page: $0) {[weak self] result in
                var fetchedMovies : [Movie]
                switch(result){
                case .success(let moviesResult):
                    fetchedMovies = moviesResult?.results ?? []
                case .failure(_):
                    fetchedMovies = []
                }
                
                self?.barrierQueue.async(flags: .barrier) {[weak self] in
                    if let weakSelf = self
                    {
                        weakSelf.fetchedMoviePages[page - 1] = fetchedMovies
                        if (weakSelf.allFetched())
                        {
                            weakSelf.delegate?.allPagesFetched()
                        }
                    }
                }
            }
        }
    }
    
    func allFetched() -> Bool
    {
        return fetchedMoviePages.compactMap{$0}.count == fetchedMoviePages.count
    }
}
