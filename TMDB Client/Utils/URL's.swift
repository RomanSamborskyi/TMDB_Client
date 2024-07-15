//
//  URL's.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation


enum Authantication {
    case token_request(key: String), session_with_login(key: String), newSession(key: String), deleteSession(key: String)
    
    var url: String {
        switch self {
        case .token_request(let key):
            return "https://api.themoviedb.org/3/authentication/token/new?api_key=\(key)"
        case .session_with_login(let key):
            return "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(key)"
        case .newSession(let key):
            return "https://api.themoviedb.org/3/authentication/session/new?api_key=\(key)"
        case .deleteSession(let key):
            return "https://api.themoviedb.org/3/authentication/session?api_key=\(key)"
        }
    }
}

enum AccountUrl {
    case accDetail(key: String, sessionId: String), lists(key: String, accountId: Int), watchList(accountId: Int, key: String)
    
    var url: String {
        switch self {
        case .accDetail(let key, let sessionId):
            return "https://api.themoviedb.org/3/account?api_key=\(key)&session_id=\(sessionId)"
        case .lists(let key, let accountId):
            return "https://api.themoviedb.org/3/account/\(accountId)/lists?api_key=\(key)"
        case .watchList(accountId: let accountId, key: let key):
            return "https://api.themoviedb.org/3/account/\(accountId)/watchlist/movies?api_key=\(key)"
        }
    }
}

enum MoviesUrls {
    case trending(key: String), upcoming(key: String), topRated(key: String), byGenre(key: String, genre: Int), allGenres(key: String)
    
    var url: String {
        switch self {
        case .trending(let key):
            return "https://api.themoviedb.org/3/trending/movie/day?api_key=\(key)"
        case .upcoming(let key):
            return "https://api.themoviedb.org/3/movie/upcoming?api_key=\(key)&page=1"
        case .topRated(let key):
            return "https://api.themoviedb.org/3/movie/top_rated?api_key=\(key)&page=1"
        case .byGenre(key: let key, genre: let genre):
            return "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre)"
        case .allGenres(key: let key):
            return "https://api.themoviedb.org/3/genre/movie/list?api_key=\(key)"
        }
    }
}
