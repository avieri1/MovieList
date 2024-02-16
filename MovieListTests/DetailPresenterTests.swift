//
//  DetailPresenterTests.swift
//  MovieListTests
//
//  Created by aldo on 16/02/24.
//

import XCTest
import Moya
@testable import MovieList

final class DetailPresenterTests: XCTestCase {

    var presenter: DetailPresenter!
    var mockView: MockDetailView!
    var mockInteractor: MockDetailInteractor!
    
    override func setUp() {
        super.setUp()
        presenter = DetailPresenter()
        mockView = MockDetailView()
        mockInteractor = MockDetailInteractor()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        
    }
    
    func testGetToFetchDetail() throws {
        presenter.fetchDatas(with: 28, with: "en-US")
        XCTAssertTrue(mockInteractor.invokedDetailGetter)
    }
    func testGetToFetchVideo() throws {
        presenter.fetchVideos(with: 28, with: "en-US")
        XCTAssertTrue(mockInteractor.invokedVideoGetter)
    }
    func testGetToFetchReview() throws {
        presenter.fetchReviews(with: 28, with: "en-US", with: 1)
        XCTAssertTrue(mockInteractor.invokedReviewGetter)
    }
    
    func testViewShowWithDetailResult() throws {
       
        presenter.interactorDidFetchMovieDetail(with: .success(StubMMovieResult.movie))
        XCTAssertTrue(mockView.detailMovie?.title == "The Endless Summer")
    }
    
    func testViewShowWithVideoResult() throws {
       
        presenter.interactorDidFetchMovieVideos(with: .success(StubMMovieResult.video))
        XCTAssertTrue(mockView.movieVideos?.results?[0].name == "The Endless Summer - Trailer")
    }
    
    func testViewShowWithReviewResult() throws {
       
        presenter.interactorDidFetchMovieReviews(with: .success(StubMMovieResult.review))
        XCTAssertTrue(mockView.movieReviews?.results?[0].author_details?.username == "IanBeale")
    }
    
    func testViewShowNoDetail() throws {
       
        presenter.interactorDidFetchMovieDetail(with: .success(StubMMovieResult.NoMovie))
        XCTAssertTrue(mockView.detailMovie?.title == "")
    }
    
    func testViewShowNoVideo() throws {
       
        presenter.interactorDidFetchMovieVideos(with: .success(StubMMovieResult.noVideo))
        XCTAssertTrue(mockView.movieVideos?.results?.count == 0)
    }
    
    func testViewShowNoReview() throws {
       
        presenter.interactorDidFetchMovieReviews(with: .success(StubMMovieResult.noReview))
        XCTAssertTrue(mockView.movieReviews?.results?.count == 0)
    }
    
    
    func testViewOpened() throws {
        
        presenter.notifyViewDidLoad()
        
        XCTAssertTrue(mockView.invokedSetupView)
    }
    
    class MockDetailView: DetailViewInterface {
        
        var id: Int?
        
        var presenter: DetailPresenterInterface?
        
        var detailMovie: DetailMovie?
        
        var movieVideos: DetailMovieVideo?
        
        var movieReviews: ReviewMovie?
        
        var invokedSetupView = false
        
        func showView(with result: MovieList.DetailMovie) {
            self.detailMovie = result
        }
        
        func showVideo(with result: MovieList.DetailMovieVideo) {
            self.movieVideos = result
        }
        
        func showReviews(with result: MovieList.ReviewMovie) {
            self.movieReviews = result
        }
        
        
        func setupView() {
            invokedSetupView = true
        }
    }
    
    class MockDetailInteractor: DetailInteractorInterface {
        
        var invokedDetailGetter = false
        var invokedVideoGetter = false
        var invokedReviewGetter = false
        
        var provider = Moya.MoyaProvider<MovieList.API>(plugins: [NetworkLoggerPlugin()])
        
        var presenter: DetailPresenterInterface?
        
        var detailMovie: DetailMovie?
        
        var movieVideos: DetailMovieVideo?
        
        var movieReviews: ReviewMovie?
        
        func getMovieDetail(id: Int, lang: String, completion: @escaping (Bool) -> ()) {
            invokedDetailGetter = true
        }
        
        func getMovieVideos(id: Int, lang: String, completion: @escaping (Bool) -> ()) {
            invokedVideoGetter = true
        }
        
        func getMovieReviews(id: Int, lang: String, page: Int, completion: @escaping (Bool) -> ()) {
            invokedReviewGetter = true
        }

    }
    
    struct StubMMovieResult {
        static let movie = DetailMovie(id: 21, release_date: "1966-06-15", revenue: 0, title: "The Endless Summer")
        static let NoMovie = DetailMovie(id: 0, release_date: "", revenue: 0, title: "")
        
        static let video = DetailMovieVideo(id: 21, results: [videoResult(name: "The Endless Summer - Trailer", key: "yZsuQXKkPdw", site: "YouTube", type: "Trailer")])
        static let noVideo = DetailMovieVideo(id: 0, results: [])
        
        static let review = ReviewMovie(results: [reviewResult(author: "Ian Beale", author_details: authorDetails(name: "Ian Beale", username: "IanBeale", rating: 5))])
        static let noReview = ReviewMovie(results: [])
        
    }

}
