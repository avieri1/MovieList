//
//  API.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation
import Moya

enum API {
    case getGenre(lang: String)
    case getMovies(lang: String, page: Int, sortBy: String, genresID: Int)
    case getDetailMovie(lang: String, id: Int)
    case getMovieVideos(lang: String, id: Int)
    case getMovieReviews(lang: String, id: Int, page: Int)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.API.baseUrl) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .getGenre:
            return Constants.API.genre
        case .getMovies:
            return Constants.API.movies
        case .getDetailMovie(_, let id):
            return Constants.API.movieDetail + "\(id)"
        case .getMovieVideos(_, let id):
            return Constants.API.movieDetail + "/\(id)/" + "videos"
        case.getMovieReviews(_, let id,_):
            return Constants.API.movieDetail + "/\(id)/" + "reviews"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getGenre(let lang):
            let param = ["language" : lang] as [String : Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getMovies(let lang, let page, let sortBy, let genresID):
            let param = ["language" : lang,
                         "page": page,
                         "sort_by": sortBy,
                         "with_genres": genresID] as [String : Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getDetailMovie(let lang,_):
            let param = ["language" : lang] as [String : Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getMovieVideos(let lang,_):
            let param = ["language" : lang] as [String : Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getMovieReviews(let lang,_, let page):
            let param = ["language" : lang,
                         "page": page] as [String : Any]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDM1MTZmYTgxMDQxMzRkNDMxM2I2NTdlMWMzOTIyNiIsInN1YiI6IjYxMWI2MGQ5ZTU0ZDVkMDA0NmNjZTI3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6NH103yayNPFVClDwBd9S4Q5cFosU_pTLJbF8SQrcOc"]
    }
    
    
}
