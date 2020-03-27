//
//  ArixMoviesTests.swift
//  ArixMoviesTests
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import XCTest
@testable import ArixMovies

class ArixMoviesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNowPlayingFeed() throws
    {
        let exp = XCTestExpectation(description: "Fetch Now Playing Feed")
        let client = MovieClient()
        client.getFeed(from: .nowPlaying) {result in
            switch result {
            case .success(let movieFeedResult):
                guard let movieResults = movieFeedResult?.results else { return }
                print(movieResults)
                exp.fulfill()
            case .failure(let error):
                print("the error \(error)")
            }
        }

        wait(for: [exp], timeout: 20, enforceOrder: false)
    }

    func testTopRatedFeed() throws
    {
        let exp = XCTestExpectation(description: "Fetch Top Rated Feed")
        let client = MovieClient()
        client.getFeed(from: .topRated) {result in
            switch result {
            case .success(let movieFeedResult):
                guard let movieResults = movieFeedResult?.results else { return }
                print(movieResults)
                exp.fulfill()
            case .failure(let error):
                print("the error \(error)")
            }
        }

        wait(for: [exp], timeout: 20, enforceOrder: false)
    }

    func testGenres() throws
    {
        let exp = XCTestExpectation(description: "Fetch Genres")
        let client = MovieClient()
        
        client.getGenres { result in
            switch result {
            case .success(let genresResult):
                guard let genres = genresResult?.genres else { return }
                print(genres)
                exp.fulfill()
            case .failure(let error):
                print("the error \(error)")
            }
        }

        wait(for: [exp], timeout: 20, enforceOrder: false)
    }

}
