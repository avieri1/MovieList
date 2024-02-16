//
//  HomeInteractor.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation
import Moya

protocol HomeInteractorInterface {
    var provider: MoyaProvider<API> { get }
    var presenter: HomePresenterInterface? { get set }
    var genre: Genre? { get }
    func fetchGenre(lang: String, completion: @escaping (Bool) -> ())
}

class HomeInteractor: HomeInteractorInterface {
    var genre: Genre?
    
    var provider = Moya.MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    var presenter: HomePresenterInterface?
    
    func fetchGenre(lang: String, completion: @escaping (Bool) -> ()) {
        provider.request(.getGenre(lang: lang)) { result in
            
            completion(true)
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Genre.self, from: response.data)
                    self.genre = results
                    self.presenter?.interactorDidFetchGenre(with: .success(results))
                } catch let error {
                    self.presenter?.interactorDidFetchGenre(with: .failure(error))
                    print("\(error.localizedDescription)")
                }
            case let .failure(error):
                self.presenter?.interactorDidFetchGenre(with: .failure(error))
            }
        }
    }
    
    
}

