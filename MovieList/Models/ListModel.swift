//
//  ListModel.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation


struct ListMovie: Decodable {
    var page: Int?
    var results: [results]?
}

struct results: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var vote_average: Double?
    var vote_count: Int?
    
}

