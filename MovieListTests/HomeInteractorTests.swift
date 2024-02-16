//
//  InteractorTests.swift
//  MovieListTests
//
//  Created by aldo on 16/02/24.
//

import XCTest
@testable import MovieList

final class HomeInteractorTests: XCTestCase {

    var interactor: HomeInteractorInterface!
    
    override func setUp() {
        super.setUp()
        
        interactor = HomeInteractor()
        
    }
    
    func testFetchGenreSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetched done")
        interactor.fetchGenre(lang: "en"){ done in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(interactor.genre)
    }
    
    
    func testFetchGenreCorrect() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.fetchGenre(lang: "en") { done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let genre = interactor.genre else {
            XCTFail("Nil Genre List Returned")
            return
        }

        XCTAssertEqual(genre.genres?[0].name, StubGenreResult.genre.genres?[0].name )
    }
    
    func testFetchGenreFalse() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.fetchGenre(lang: "en") { done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let genre = interactor.genre else {
            XCTFail("Nil Genre List Returned")
            return
        }

        XCTAssertNotEqual(genre.genres?[2].name, StubGenreResult.genre.genres?[0].name )
    }
    
    
    struct StubGenreResult {
        static let genre = Genre(genres: [Genres(id:28, name: "Action")])
    }

}
