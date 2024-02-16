//
//  HomeRouter.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import UIKit
typealias EntryPoint = HomeViewInterface & UIViewController

protocol HomeRouterInterface {
    var entry: EntryPoint? { get }
    
    static func start() -> HomeRouterInterface
    func pushToList(on view: HomeViewInterface, with id: Int)
}

class HomeRouter: HomeRouterInterface {
    
    var entry: EntryPoint?
    
    static func start() -> HomeRouterInterface {
        let router = HomeRouter()
        
        var view: HomeViewInterface = HomeVC()
        let presenter: HomePresenterInterface = HomePresenter()
        var interactor: HomeInteractorInterface = HomeInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router  = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
    
        return router
    }
    
    func pushToList(on view: HomeViewInterface, with id: Int) {
        DispatchQueue.main.async {
            let listVC = ListRouter.start(with: id)
            let vc = view as! HomeVC
            vc.navigationController?.pushViewController(listVC, animated: true)
        }
    }
    

}
