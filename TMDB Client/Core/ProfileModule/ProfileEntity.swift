//
//  ProfileEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit

// MARK: - User
struct UserProfile: Codable {
    
    let avatar: Avatar?
    let id: Int?
    let iso639_1, iso3166_1, name: String?
    let includeAdult: Bool?
    let username: String?
    let uiImageAvatar: Data?

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
        case uiImageAvatar
    }
}

extension UserProfile: Comparable {
    static func < (lhs: UserProfile, rhs: UserProfile) -> Bool {
        true
    }
    
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        lhs.id == rhs.id || lhs.name == rhs.name || lhs.username == rhs.username || lhs
            .iso3166_1 == rhs.iso3166_1 || lhs.iso639_1 == rhs.iso3166_1 
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar?
    let tmdb: Tmdb?
}

extension Avatar: Equatable {
    static func == (lhs: Avatar, rhs: Avatar) -> Bool {
        lhs.gravatar == rhs.gravatar || lhs.tmdb == rhs.tmdb
    }
}
// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String?
}
extension Gravatar: Equatable {
    
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}

extension Tmdb: Equatable {
    
}

struct DeleteSession: Codable {
    let success: Bool
}
