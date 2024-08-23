//
//  URL's.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation


enum ImageURL {
    case imagePath(path: String), gravatarPath(path: String)
    
    var url: String {
        switch self {
        case .imagePath(let path):
            return "https://image.tmdb.org/t/p/w500\(path)"
        case .gravatarPath(let path):
            return "https://www.gravatar.com/avatar/\(path)?s=200"
        }
    }
}

enum ListURL {
    case detail(listsId: Int, apiKey: String), clear(listId: Int, key: String, sessionId: String), delete(listId: Int, apiKey: String, sessionId: String), deleteMovie(listId: Int, apiKey: String, sessionId: String), addMovie(listId: Int, apiKey: String, sessionId: String), create(apiKey: String, sessionId: String)
    
    var url: String {
        switch self {
        case .detail(let id, let key):
            return "https://api.themoviedb.org/3/list/\(id)?api_key=\(key)"
        case .clear(listId: let listId, key: let key, sessionId: let sessionId):
            return "https://api.themoviedb.org/3/list/\(listId)/clear?api_key=\(key)&session_id=\(sessionId)&confirm=true"
        case .delete(listId: let listId, apiKey: let apiKey, sessionId: let sessionId):
            return "https://api.themoviedb.org/3/list/\(listId)?api_key=\(apiKey)&session_id=\(sessionId)"
        case .deleteMovie(listId: let listId, apiKey: let apiKey, sessionId: let sessionId):
            return "https://api.themoviedb.org/3/list/\(listId)/remove_item?api_key=\(apiKey)&session_id=\(sessionId)"
        case .addMovie(listId: let listId, apiKey: let apiKey, sessionId: let sessionId):
            return "https://api.themoviedb.org/3/list/\(listId)/add_item?api_key=\(apiKey)&session_id=\(sessionId)"
        case .create(apiKey: let apiKey, sessionId: let sessionId):
            return "https://api.themoviedb.org/3/list?api_key=\(apiKey)&session_id=\(sessionId)"
        }
    }
}

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
    case accDetail(key: String, sessionId: String), lists(key: String, accountId: Int), watchList(accountId: Int, key: String), accountState(key: String, movieId: Int, sessionId: String)
    
    var url: String {
        switch self {
        case .accDetail(let key, let sessionId):
            return "https://api.themoviedb.org/3/account?api_key=\(key)&session_id=\(sessionId)"
        case .lists(let key, let accountId):
            return "https://api.themoviedb.org/3/account/\(accountId)/lists?api_key=\(key)"
        case .watchList(accountId: let accountId, key: let key):
            return "https://api.themoviedb.org/3/account/\(accountId)/watchlist/movies?api_key=\(key)"
        case .accountState(key: let key, movieId: let movieId, sessionId: let sessionId):
            return "https://api.themoviedb.org/3/movie/\(movieId)/account_states?api_key=\(key)&session_id=\(sessionId)"
        }
    }
}

enum MoviesUrls {
    case trending(key: String), upcoming(key: String), topRated(key: String), byGenre(key: String, genre: Int), allGenres(key: String), singleMovie(movieId: Int, key: String), addToFavorite(accoutId: Int, key: String), addRating(movieId: Int, sessionId: String, key: String), searchMovie(apiKey: String, title: String)
    
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
        case .singleMovie(movieId: let movieId, key: let key):
            return "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(key)"
        case .addToFavorite(accoutId: let accoutId, key: let key):
            return "https://api.themoviedb.org/3/account/\(accoutId)/favorite?api_key=\(key)"
        case .addRating(movieId: let movieId, sessionId: let sessionId, key: let key):
            return "https://api.themoviedb.org/3/movie/\(movieId)/rating?api_key=\(key)&session_id=\(sessionId)"
        case .searchMovie(apiKey: let apiKey, title: let title):
            return "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(title)"
        }
    }
}
