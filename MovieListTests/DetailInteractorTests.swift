//
//  DetailInteractorTests.swift
//  MovieListTests
//
//  Created by aldo on 16/02/24.
//

import XCTest
@testable import MovieList

final class DetailInteractorTests: XCTestCase {

    var interactor: DetailInteractorInterface!
    
    override func setUp() {
        super.setUp()
        
        interactor = DetailInteractor()
        
    }
    
    func testFetchDetailMovieSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetched done")
        interactor.getMovieDetail(id: 21, lang: "en-US"){ done in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(interactor.detailMovie)
    }
    
    func testFetchMovieVideoSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetched done")
        interactor.getMovieVideos(id: 21, lang: "en-US"){ done in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(interactor.movieVideos)
    }
    
    func testFetchMovieReviewsSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetched done")
        interactor.getMovieReviews(id: 21, lang: "en-US", page: 1){ done in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(interactor.movieReviews)
    }
    
    
    func testFetchMovieDetailCorrect() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getMovieDetail(id: 21, lang: "en-US"){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let movie = interactor.detailMovie else {
            XCTFail("Nil Movie Returned")
            return
        }

        XCTAssertEqual(movie.title, StubMMovieResult.movie.title)
    }
    
    func testFetchMovieVideoCorrect() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getMovieVideos(id: 21, lang: "en-US"){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let video = interactor.movieVideos else {
            XCTFail("Nil Video Returned")
            return
        }

        XCTAssertEqual(video.results?[0].name, StubMMovieResult.video.results?[0].name)
    }
    
    func testFetchMovieReviewCorrect() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getMovieReviews(id: 28, lang: "en-US", page: 1){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let review = interactor.movieReviews else {
            XCTFail("Nil Review Returned")
            return
        }

        XCTAssertEqual(review.results?[0].author_details?.username, StubMMovieResult.review.results?[0].author_details?.username)
    }
    
    
    func testFetchMovieDetailFalse() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getMovieDetail(id: 24, lang: "en-US"){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let movie = interactor.detailMovie else {
            XCTFail("Nil Movie Returned")
            return
        }

        XCTAssertNotEqual(movie.title, StubMMovieResult.movie.title )
    }
    
    func testFetchMovieVideoFalse() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getMovieVideos(id: 24, lang: "en-US"){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let video = interactor.movieVideos else {
            XCTFail("Nil Video Returned")
            return
        }

        XCTAssertNotEqual(video.results?[0].name, StubMMovieResult.video.results?[0].name)
    }
    
    func testFetchMovieReviewFalse() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getMovieReviews(id: 32, lang: "en-US", page: 1){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let review = interactor.movieReviews else {
            XCTFail("Nil Review Returned")
            return
        }

        XCTAssertNotEqual(review.results?[0].author_details?.username, StubMMovieResult.review.results?[0].author_details?.username)
    }
    
    
    struct StubMMovieResult {
        static let movie = DetailMovie(id: 21, release_date: "1966-06-15", revenue: 0, title: "The Endless Summer")
        static let video = DetailMovieVideo(id: 21, results: [videoResult(name: "The Endless Summer - Trailer", key: "yZsuQXKkPdw", site: "YouTube", type: "Trailer")])
        
        static let review = ReviewMovie(results: [reviewResult(author: "Ian Beale", author_details: authorDetails(name: "Ian Beale", username: "IanBeale", rating: 5))])
        
    }

}
