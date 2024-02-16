//
//  DetailModel.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation

struct DetailMovie: Decodable {
    var adult: Bool?
    var budget: Int?
    var genres: [detailGenres]?
    var homepage: String?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var status: String?
    var title: String?
    var vote_average: Double?
    var vote_count: Int?
}

struct detailGenres: Codable {
    var id: Int?
    var name: String?
}


struct DetailMovieVideo: Decodable {
    var id: Int?
    var results: [videoResult]?
}

struct videoResult: Codable {
    var iso_639_1: String?
    var iso_3166_1: String?
    var name: String?
    var key: String?
    var site: String?
    var size: Int?
    var type: String?
    var official: Bool?
    var published_at: String?
    var id: String?
}


