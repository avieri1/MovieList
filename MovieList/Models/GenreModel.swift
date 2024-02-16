//
//  Genre.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import Foundation

struct Genre: Decodable {
    var genres: [Genres]?
}

struct Genres: Codable {
    var id: Int?
    var name: String?
}
