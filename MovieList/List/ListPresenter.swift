//
//  ListPresenter.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation

protocol ListPresenterInterface {
    var router: ListRouterInterface? { get set }
    var interactor: ListInteractorInterface? { get set }
    var view: ListViewInterface? { get set }
    func fetchDatas(with id: Int, with lang: String, with page: Int, with sortBy: String)
    func notifyViewDidLoad()
    func interactorDidFetchListMovie(with result: Result<ListMovie, Error>)
    func viewPushToDetail(with id: Int)
}

class ListPresenter: ListPresenterInterface {
   
    
    var router: ListRouterInterface?
    
    var interactor: ListInteractorInterface?
    
    var view: ListViewInterface?
    
    func notifyViewDidLoad() {
        view?.setupView()
    }
    
    func fetchDatas(with id: Int, with lang: String, with page: Int, with sortBy: String) {
        interactor?.getListMovie(id: id, lang: lang, page: page, sortBy: sortBy, completion: { _ in
            
        })
    }
    
    func interactorDidFetchListMovie(with result: Result<ListMovie, Error>) {
        switch result {
        case .success(let results):
            print(results)
            view?.showView(with: results)
        case .failure(let error):
            print(error)
        }
    }
    
    func viewPushToDetail(with id: Int) {
        router?.pushToDetail(on: view!, with: id)
    }
    
}
