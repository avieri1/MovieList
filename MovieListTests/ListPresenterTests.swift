//
//  ListPresenterTests.swift
//  MovieListTests
//
//  Created by aldo on 16/02/24.
//

import XCTest
import Moya
@testable import MovieList

final class ListPresenterTests: XCTestCase {

    var presenter: ListPresenter!
    var mockView: MockListView!
    var mockInteractor: MockListInteractor!
    
    override func setUp() {
        super.setUp()
        presenter = ListPresenter()
        mockView = MockListView()
        mockInteractor = MockListInteractor()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        
    }
    
    func testGetToFetchData() throws {
        presenter.fetchDatas(with: 12, with: "en-US", with: 1, with: "popularity.desc")
        XCTAssertTrue(mockInteractor.invokedDatasGetter)
    }
    
    func testViewShowWithResult() throws {
       
        presenter.interactorDidFetchListMovie(with: .success(StubListResult.list))
       
        XCTAssertTrue(mockView.listMovie?.results?.count == 1)
    }
    
    func testViewShowNoResult() throws {
       
        presenter.interactorDidFetchListMovie(with: .success(StubListResult.Nolist))
       
        XCTAssertTrue(mockView.listMovie?.results?.count == 0)
    }
    
    func testViewOpened() throws {
        
        presenter.notifyViewDidLoad()
        
        XCTAssertTrue(mockView.invokedSetupView)
    }
    
    class MockListView: ListViewInterface {
        
        var presenter: ListPresenterInterface?
        var listMovie: ListMovie?
        
        var id: Int?
        var invokedSetupView = false
        
        func showView(with result: MovieList.ListMovie) {
            self.listMovie = result
        }
        
        func setupView() {
            invokedSetupView = true
        }
    }
    
    class MockListInteractor: ListInteractorInterface {
        
        var presenter: ListPresenterInterface?
        
        var listMovie: ListMovie?
        
        var invokedDatasGetter = false
        
        var provider = Moya.MoyaProvider<MovieList.API>(plugins: [NetworkLoggerPlugin()])
        
    
        func getListMovie(id: Int, lang: String, page: Int, sortBy: String, completion: @escaping (Bool) -> ()) {
            invokedDatasGetter = true
        }
        

    }
    
    struct StubListResult {
        static let list = ListMovie(page: 1, results: [results(id: 609681, title: "The Marvels")])
        static let Nolist = ListMovie(page: 1, results: [])
    }

}
