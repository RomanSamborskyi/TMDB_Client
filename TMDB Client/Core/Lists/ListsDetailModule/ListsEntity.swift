//
//  ListsEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 27.07.2024.
//

import Foundation

struct ListDetail: Codable {
    let createdBy, description: String?
    let favoriteCount, id: Int?
    let iso639_1: String?
    let itemCount: Int?
    let items: [Movie]?
    let name: String?
    let page: Int?
    let posterPath: String?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case description
        case favoriteCount = "favorite_count"
        case id
        case iso639_1 = "iso_639_1"
        case itemCount = "item_count"
        case items, name, page
        case posterPath = "poster_path"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
