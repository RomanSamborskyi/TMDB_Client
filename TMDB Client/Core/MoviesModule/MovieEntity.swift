//
//  MovieEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 12.07.2024.
//

import UIKit



struct MovieResult: Codable, Hashable, IteratorProtocol, Sequence {
    mutating func next() -> MovieResult? {
        nil
    }
    
    typealias Element = Self
    
    let page: Int
    let results: [Movie]
    let total_pages: Int
}


struct Movie: Identifiable, Hashable, Codable, IteratorProtocol, Sequence {
    mutating func next() -> Movie? {
        nil
    }
    
    typealias Element = Self
    
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let genres: [Genre]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var isFavorite: Bool?
    var inList: Bool?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case genres
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct Genre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
