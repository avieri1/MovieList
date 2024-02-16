//
//  ReviewModel.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation

struct ReviewMovie: Decodable {
    var id: Int?
    var page: Int?
    var total_pages: Int?
    var results: [reviewResult]?
}

struct reviewResult: Codable {
    var id: String?
    var author: String?
    var author_details: authorDetails?
    var content: String?
    var created_at: String?
    var updated_at: String?
}

struct authorDetails: Codable {
    var name: String?
    var username: String?
    var avatar_path: String?
    var rating: Int?
}

