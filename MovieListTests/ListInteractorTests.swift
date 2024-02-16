//
//  ListInteractorTests.swift
//  MovieListTests
//
//  Created by aldo on 16/02/24.
//

import XCTest
@testable import MovieList

final class ListInteractorTests: XCTestCase {

    var interactor: ListInteractorInterface!
    
    override func setUp() {
        super.setUp()
        
        interactor = ListInteractor()
        
    }
    
    func testFetchListSuccess() throws {
        let expectation = XCTestExpectation(description: "Fetched done")
        interactor.getListMovie(id: 12, lang: "en", page: 1, sortBy: "popularity.desc"){ done in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(interactor.listMovie)
    }
    
    
    func testFetchListCorrect() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getListMovie(id: 12, lang: "en", page: 1, sortBy: "popularity.desc"){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let list = interactor.listMovie else {
            XCTFail("Nil List Returned")
            return
        }

        XCTAssertEqual(list.results?[0].title, StubListResult.list.results?[0].title )
    }
    
    func testFetchListFalse() throws {
        let expectation = XCTestExpectation(description: "Fetched is Correct")
        interactor.getListMovie(id: 12, lang: "en", page: 1, sortBy: "popularity.desc"){ done in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        guard let list = interactor.listMovie else {
            XCTFail("Nil List Returned")
            return
        }

        XCTAssertNotEqual(list.results?[2].title, StubListResult.list.results?[0].title )
    }
    
    
    struct StubListResult {
        static let list = ListMovie(page: 1, results: [results(id: 609681, title: "The Marvels")])
    }

}
