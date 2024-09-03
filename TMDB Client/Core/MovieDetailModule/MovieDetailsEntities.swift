//
//  MovieDetailsEntities.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import Foundation

//MARK: - rate body
struct RateBody: Codable {
    let value: Double
}

//MARK: - Rate state
enum RateStatus: Codable {
    case notRated(Bool)
    case rated(RateValue)
    
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let boolValue = try? container.decode(Bool.self) {
            self = .notRated(boolValue)
        } else if let ratedValue = try? container.decode(RateValue.self) {
            self = .rated(ratedValue)
        } else {
            throw DecodingError.typeMismatch(RateStatus.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid to decode"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .notRated(let boolValue):
            try container.encode(boolValue)
        case .rated(let rateValue):
            try container.encode(rateValue)
        }
    }
}
//MARK: - Movie Stat
struct MovieStat: Codable {
    let id: Int?
    let favorite: Bool?
    let rated: RateStatus?
    let watchlist: Bool?
}
//MARK: - Rate value
struct RateValue: Codable {
    let value: Double?
}
//MARK: - AddToWatchlist
struct AddToWatchlist: Codable {
   let media_type: String?
   let media_id: Int
   let watchlist: Bool
}
//MARK: - AddToFavorite
struct AddToFavorite: Codable {
   let media_type: String?
   let media_id: Int
   let favorite: Bool
}

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var watchList: Bool?
    var favorite: Bool?
    var myRate: Double?
    var inList: Bool?
   
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
