//
//  HomePresenter.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation

protocol HomePresenterInterface: AnyObject {
    var router: HomeRouterInterface? { get set }
    var interactor: HomeInteractorInterface? { get set }
    var view: HomeViewInterface? { get set }
 
    func notifyViewDidLoad()
    func fetchDatas(with lang: String)
    func interactorDidFetchGenre(with result: Result<Genre, Error>)
    func viewPushToList(with id: Int)
}

class HomePresenter: HomePresenterInterface {
    
    var interactor: HomeInteractorInterface?
    var router: HomeRouterInterface?
    var view: HomeViewInterface?
    
    func notifyViewDidLoad() {
        view?.setupView()
    }
    
    func fetchDatas(with lang: String) {
        interactor?.fetchGenre(lang: lang, completion: { _ in
        })
    }
    
    func interactorDidFetchGenre(with result: Result<Genre, Error>) {
        switch result {
        case .success(let results):
            print(results)
            view?.showView(with: results)
        case .failure(let error):
            print(error)
        }
    }
    
    func viewPushToList(with id: Int) {
        router?.pushToList(on: view!, with: id)
    }
    
    
}
