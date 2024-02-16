//
//  DetailPresenter.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation

protocol DetailPresenterInterface {
    var router: DetailRouterInterface? { get set }
    var interactor: DetailInteractorInterface? { get set }
    var view: DetailViewInterface? { get set }
    func fetchDatas(with id: Int, with lang: String)
    func fetchVideos(with id: Int, with lang: String)
    func fetchReviews(with id: Int, with lang: String, with page: Int)
    func notifyViewDidLoad()
    func interactorDidFetchMovieDetail(with result: Result<DetailMovie, Error>)
    func interactorDidFetchMovieVideos(with result: Result<DetailMovieVideo, Error>)
    func interactorDidFetchMovieReviews(with result: Result<ReviewMovie, Error>)
}

class DetailPresenter: DetailPresenterInterface {
    
    
    var router: DetailRouterInterface?
    
    var interactor: DetailInteractorInterface?
    
    var view: DetailViewInterface?
    
    func fetchDatas(with id: Int, with lang: String) {
        interactor?.getMovieDetail(id: id, lang: lang, completion: { _ in
        })
    }
    
    func fetchVideos(with id: Int, with lang: String) {
        interactor?.getMovieVideos(id: id, lang: lang, completion: { _ in
        })
    }
    
    func fetchReviews(with id: Int, with lang: String, with page: Int) {
        interactor?.getMovieReviews(id: id, lang: lang, page: page, completion: { _ in
        })
    }
    
    func notifyViewDidLoad() {
        view?.setupView()
    }
    
    func interactorDidFetchMovieDetail(with result: Result<DetailMovie, Error>) {
        switch result {
        case .success(let results):
            print(results)
            view?.showView(with: results)
        case .failure(let error):
            print(error)
        }
    }
    
    func interactorDidFetchMovieVideos(with result: Result<DetailMovieVideo, Error>) {
        switch result {
        case .success(let results):
            print(results)
            view?.showVideo(with: results)
        case .failure(let error):
            print(error)
        }
    }
    
    func interactorDidFetchMovieReviews(with result: Result<ReviewMovie, Error>) {
        switch result {
        case .success(let results):
            view?.showReviews(with: results)
        case .failure(let error):
            print(error)
        }
    }
    
    
}
