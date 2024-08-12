//
//  ListEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


//MARK: - clear list response
struct ClearList: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessege: String
    
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessege = "status_message"
    }
}

// MARK: - Lists
struct ListsResponse: Codable {
    let page: Int?
    let results: [List]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct List: Codable {
    let description: String?
    let favoriteCount: Int?
    let id: Int?
    let itemCount: Int?
    let iso639_1: String?
    let listType: String?
    let name: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case description
        case favoriteCount = "favorite_count"
        case id
        case itemCount = "item_count"
        case iso639_1 = "iso_639_1"
        case listType = "list_type"
        case name
        case posterPath = "poster_path"
    }
}

