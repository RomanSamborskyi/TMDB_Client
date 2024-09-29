//
//  MoviesCastEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 22.09.2024.
//

import UIKit


import Foundation

// MARK: - CastResponse
struct CastResponse: Codable {
    let id: Int
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let alsoKnownAs: [String]?
    let biography, birthday: String?
    let deathday: String?
    let gender: Int
    let homepage: String?
    let id: Int?
    let imdbID, knownForDepartment, name, placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}
//MARK: movies with Persone
struct ActrorsMovies: Codable {
    let cast: [Movie]
}
