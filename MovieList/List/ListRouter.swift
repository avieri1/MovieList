//
//  ListRouter.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation
import UIKit

protocol ListRouterInterface {
    
    static func start(with id: Int) -> UIViewController
    func pushToDetail(on view: ListViewInterface, with id: Int)
}

class ListRouter: ListRouterInterface {
   
    static func start(with id: Int) -> UIViewController {
        let viewController = ListVC()
        
        let presenter: ListPresenterInterface = ListPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = ListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ListInteractor()
        viewController.id = id
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToDetail(on view: ListViewInterface, with id: Int) {
        DispatchQueue.main.async {
            let detailVC = DetailRouter.start(with: id)
            let vc = view as! ListVC
            vc.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
}
