//
//  DetailRouter.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation
import UIKit

protocol DetailRouterInterface {
    
    static func start(with id: Int) -> UIViewController
}

class DetailRouter: DetailRouterInterface {
   
    static func start(with id: Int) -> UIViewController {
        let viewController = DetailVC()
        
        var presenter: DetailPresenterInterface = DetailPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = DetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailInteractor()
        viewController.id = id
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    
}
