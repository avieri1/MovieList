//
//  ListInteractor.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation
import Moya

protocol ListInteractorInterface {
    var provider: MoyaProvider<API> { get }
    var presenter: ListPresenterInterface? { get set }
    var listMovie: ListMovie? { get }
    func getListMovie(id: Int, lang: String, page: Int, sortBy: String, completion: @escaping (Bool) -> ())
}

class ListInteractor: ListInteractorInterface {
    var listMovie: ListMovie?

    var provider = Moya.MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    var presenter: ListPresenterInterface?
    
    func getListMovie(id: Int, lang: String, page: Int, sortBy: String, completion: @escaping (Bool) -> ())  {
        provider.request(.getMovies(lang: lang, page: page, sortBy: sortBy, genresID: id)) { result in
            
            completion(true)
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(ListMovie.self, from: response.data)
                    self.listMovie = results
                    self.presenter?.interactorDidFetchListMovie(with: .success(results))
                } catch let error {
                    self.presenter?.interactorDidFetchListMovie(with: .failure(error))
                    print("\(error.localizedDescription)")
                }
            case let .failure(error):
                self.presenter?.interactorDidFetchListMovie(with: .failure(error))
            }
        }
    }
    
    
}
