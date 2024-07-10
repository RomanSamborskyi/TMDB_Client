//
//  ProfileEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import Foundation

import Foundation

// MARK: - User
struct UserProfile: Codable {
    let avatar: Avatar
    let id: Int
    let iso639_1, iso3166_1, name: String
    let includeAdult: Bool
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatarPath: String

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}

struct DeleteSession: Codable {
    let success: Bool
}

// MARK: - Lists
struct ListsResponse: Codable {
    let page: Int
    let results: [List]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct List: Codable {
    let description: String
    let favoriteCount, id, itemCount: Int
    let iso639_1, listType, name: String
    let posterPath: String

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
