//
//  DetailInteractor.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation
import Moya

protocol DetailInteractorInterface {
    var provider: MoyaProvider<API> { get }
    var presenter: DetailPresenterInterface? { get set }
    var detailMovie: DetailMovie? { get }
    var movieVideos: DetailMovieVideo? { get }
    var movieReviews: ReviewMovie? { get }
    func getMovieDetail(id: Int, lang: String, completion: @escaping (Bool) -> ())
    func getMovieVideos(id: Int, lang: String, completion: @escaping (Bool) -> ())
    func getMovieReviews(id: Int, lang: String, page: Int, completion: @escaping (Bool) -> ())
}

class DetailInteractor: DetailInteractorInterface {
    
    var detailMovie: DetailMovie?
    
    var movieVideos: DetailMovieVideo?
    
    var movieReviews: ReviewMovie?
    
    var provider = Moya.MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    var presenter: DetailPresenterInterface?
    
    func getMovieDetail(id: Int, lang: String, completion: @escaping (Bool) -> ()) {
        provider.request(.getDetailMovie(lang: lang, id: id)) { result in
            
            completion(true)
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(DetailMovie.self, from: response.data)
                    self.detailMovie = results
                    self.presenter?.interactorDidFetchMovieDetail(with: .success(results))
                } catch let error {
                    self.presenter?.interactorDidFetchMovieDetail(with: .failure(error))
                    print("\(error.localizedDescription)")
                }
            case let .failure(error):
                self.presenter?.interactorDidFetchMovieDetail(with: .failure(error))
            }
        }
    }
    
    func getMovieVideos(id: Int, lang: String, completion: @escaping (Bool) -> ()) {
        provider.request(.getMovieVideos(lang: lang, id: id)) { result in
            
            completion(true)
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(DetailMovieVideo.self, from: response.data)
                    self.movieVideos = results
                    self.presenter?.interactorDidFetchMovieVideos(with: .success(results))
                } catch let error {
                    self.presenter?.interactorDidFetchMovieVideos(with: .failure(error))
                    print("\(error.localizedDescription)")
                }
            case let .failure(error):
                self.presenter?.interactorDidFetchMovieVideos(with: .failure(error))
            }
        }
    }
    
    func getMovieReviews(id: Int, lang: String, page: Int, completion: @escaping (Bool) -> ()) {
        provider.request(.getMovieReviews(lang: lang, id: id, page: page)) { result in
            
            completion(true)
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(ReviewMovie.self, from: response.data)
                    self.movieReviews = results
                    self.presenter?.interactorDidFetchMovieReviews(with: .success(results))
                } catch let error {
                    self.presenter?.interactorDidFetchMovieReviews(with: .failure(error))
                    print("\(error.localizedDescription)")
                }
            case let .failure(error):
                self.presenter?.interactorDidFetchMovieReviews(with: .failure(error))
            }
        }
    }
    
}
