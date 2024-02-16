//
//  HomePresenterTests.swift
//  MovieListTests
//
//  Created by aldo on 16/02/24.
//

import XCTest
import Moya
@testable import MovieList

final class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    
    override func setUp() {
        super.setUp()
        presenter = HomePresenter()
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        
    }
    
    func testGetToFetchData() throws {
        presenter.fetchDatas(with: "en")
        XCTAssertTrue(mockInteractor.invokedDatasGetter)
    }
    
    func testViewShowWithResult() throws {
       
        presenter.interactorDidFetchGenre(with: .success(StubGenreResult.genre))
       
        XCTAssertTrue(mockView.result?.genres?.count == 1)
    }
    
    func testViewShowNoResult() throws {
       
        presenter.interactorDidFetchGenre(with: .success(StubGenreResult.noGenre))
       
        XCTAssertTrue(mockView.result?.genres?.count == 0)
    }
    
    func testViewOpened() throws {
        
        presenter.notifyViewDidLoad()
        
        XCTAssertTrue(mockView.invokedSetupView)
    }
    
    class MockHomeView: HomeViewInterface {
        
        var presenter: HomePresenterInterface?
        var result: Genre?
        var invokedSetupView = false
        
        func setupView() {
            invokedSetupView = true
        }
        
        func showView(with result: MovieList.Genre) {
            self.result = result
        }
    }
    
    class MockHomeInteractor: HomeInteractorInterface {
        
        var invokedDatasGetter = false
        
        var provider = Moya.MoyaProvider<MovieList.API>(plugins: [NetworkLoggerPlugin()])
        
        var presenter: HomePresenterInterface?
        
        var genre: Genre?
        
        func fetchGenre(lang: String, completion: @escaping (Bool) -> ()) {
            invokedDatasGetter = true
        }

    }
    
    struct StubGenreResult {
        static let genre = Genre(genres: [Genres(id:28, name: "Action")])
        static let noGenre = Genre(genres: [])
    }

}
