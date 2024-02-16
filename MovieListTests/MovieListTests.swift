//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by aldo on 15/02/24.
//

import XCTest
import Moya
@testable import MovieList

final class MovieListTests: XCTestCase {

    var provider: MoyaProvider<API>!
   
    override func setUp() {
        super.setUp()
        provider = MoyaProvider<API>(stubClosure: MoyaProvider.delayedStub(0.5))
    }
    
    override func tearDown() {
        super.tearDown()
        provider = nil
    }
    
    func testGetGenre() throws {
        provider.request(.getGenre(lang: "en")) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetList() throws {
        provider.request(.getMovies(lang: "en", page: 1, sortBy: "popularity.desc", genresID: 12)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    func testGetDetailMovie() throws {
        provider.request(.getDetailMovie(lang: "en-US", id: 21)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    func testGetMovieVideo() throws {
        provider.request(.getDetailMovie(lang: "en-US", id: 21)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    func testGetMovieReviews() throws {
        provider.request(.getMovieReviews(lang: "en-US", id: 21, page: 1)) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

}
