//
//  URL's.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation


protocol URLData {
    var url: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
}

enum APIBaseURL {
    case base
    
    var url: String {
        switch self {
        case .base:
            return "https://api.themoviedb.org/3/"
        }
    }
}

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
//MARK: - ListURL
enum ListURL: URLData {
    
    case detail(listsId: Int, apiKey: String), clear(listId: Int, key: String, sessionId: String), delete(listId: Int, apiKey: String, sessionId: String), deleteMovie(listId: Int, apiKey: String, sessionId: String), addMovie(listId: Int, apiKey: String, sessionId: String), create(apiKey: String, sessionId: String)
    
    var url: String {
        switch self {
        case .detail(let id, let key):
            return "\(APIBaseURL.base.url)list/\(id)?api_key=\(key)"
        case .clear(listId: let listId, key: let key, sessionId: let sessionId):
            return "\(APIBaseURL.base.url)list/\(listId)/clear?api_key=\(key)&session_id=\(sessionId)&confirm=true"
        case .delete(listId: let listId, apiKey: let apiKey, sessionId: let sessionId):
            return "\(APIBaseURL.base.url)list/\(listId)?api_key=\(apiKey)&session_id=\(sessionId)"
        case .deleteMovie(listId: let listId, apiKey: let apiKey, sessionId: let sessionId):
            return "\(APIBaseURL.base.url)list/\(listId)/remove_item?api_key=\(apiKey)&session_id=\(sessionId)"
        case .addMovie(listId: let listId, apiKey: let apiKey, sessionId: let sessionId):
            return "\(APIBaseURL.base.url)list/\(listId)/add_item?api_key=\(apiKey)&session_id=\(sessionId)"
        case .create(apiKey: let apiKey, sessionId: let sessionId):
            return "\(APIBaseURL.base.url)list?api_key=\(apiKey)&session_id=\(sessionId)"
        }
    }
    
    var method: String {
        switch self {
        case .detail:
            return "GET"
        case .clear:
            return "POST"
        case .delete:
            return "DELETE"
        case .deleteMovie:
            return "POST"
        case .addMovie:
            return "POST"
        case .create:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .detail:
            return [:]
        case .clear:
            return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzMxOTkyMi42NjQ0Mywic3ViIjoiNjQ1M2RlYzZkNDhjZWUwMGUxMzNhMDZkIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.KOpOq5eq7eJrAXTTIubRiN9Qxo4dz1cxGIc0wYeH5ec"
              ]
        case .delete:
            return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzMxOTkyMi42NjQ0Mywic3ViIjoiNjQ1M2RlYzZkNDhjZWUwMGUxMzNhMDZkIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.KOpOq5eq7eJrAXTTIubRiN9Qxo4dz1cxGIc0wYeH5ec"
              ]
        case .deleteMovie:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzkwMTk1NS4yOTcyMzEsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hNtyiwxMDh48SXARNL3XC8GmzBqG-xHFm6ZjOGRn4zY"
              ]
        case .addMovie:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyNDA0NzIzOS41NDk5NjIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2dmT4RCVVSibsak5Eq4XMFeMJtY6gKGic29qmh5TePk"
              ]
        case .create:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyNDA0NzIzOS41NDk5NjIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2dmT4RCVVSibsak5Eq4XMFeMJtY6gKGic29qmh5TePk"
              ]
        }
    }
}
//MARK: - AuthanticationURL
enum Authantication: URLData {
    
    case token_request(key: String), session_with_login(key: String), newSession(key: String), deleteSession(key: String)
    
    var url: String {
        switch self {
        case .token_request(let key):
            return "\(APIBaseURL.base.url)authentication/token/new?api_key=\(key)"
        case .session_with_login(let key):
            return "\(APIBaseURL.base.url)authentication/token/validate_with_login?api_key=\(key)"
        case .newSession(let key):
            return "\(APIBaseURL.base.url)authentication/session/new?api_key=\(key)"
        case .deleteSession(let key):
            return "\(APIBaseURL.base.url)authentication/session?api_key=\(key)"
        }
    }
    
    var method: String {
        switch self {
        case .token_request:
            return "GET"
        case .session_with_login:
            return "POST"
        case .newSession:
            return "POST"
        case .deleteSession:
            return "DELETE"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .token_request:
           return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
              ]
        case .session_with_login:
           return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
              ]
        case .newSession:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDU0MzIwNi42NzcyNTIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdCbZoe-128Wrybd6WFkZC-3VFSuzkGXXTrxGALDleM"
              ]
        case .deleteSession:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyNDk0NzEyNS4xODQ0NzIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zwHnzqklRJIky95os0iH78OvhLeK-UzBVdsCP5AP82U"
              ]
        }
    }
}
//MARK: - AccountUrl
enum AccountUrl: URLData {
    case accDetail(key: String, sessionId: String), lists(key: String, accountId: Int, sessionId: String), watchList(accountId: Int, key: String, sessionId: String), accountState(key: String, movieId: Int, sessionId: String)
    
    var url: String {
        switch self {
        case .accDetail(let key, let sessionId):
            return "\(APIBaseURL.base.url)account?api_key=\(key)&session_id=\(sessionId)"
        case .lists(let key, let accountId, let sessionId):
            return "\(APIBaseURL.base.url)account/\(accountId)/lists?api_key=\(key)&session_id=\(sessionId)"
        case .watchList(accountId: let accountId, key: let key, let sessionId):
            return "\(APIBaseURL.base.url)account/\(accountId)/watchlist/movies?api_key=\(key)&session_id=\(sessionId)"
        case .accountState(key: let key, movieId: let movieId, sessionId: let sessionId):
            return "\(APIBaseURL.base.url)movie/\(movieId)/account_states?api_key=\(key)&session_id=\(sessionId)"
        }
    }
    
    var method: String {
        switch self {
        case .accDetail:
            return "GET"
        case .lists:
            return "GET"
        case .watchList:
            return "GET"
        case .accountState:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .lists:
            return [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMDk1MjU3MS4yMjY2OTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EG1uBVtmGkg075gO3v_SymHi36lfdYDDhAwMK_Gv1vI"
              ]
        case .watchList:
            return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMTA0NjkyNC4wMjgyNDksInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KgpKgDGA6OQQ2-8QP2QcjH0eqi7Xz_40gxlbU5OhnBo"
              ]
        default: return [:]
        }
    }
}
//MARK: - MoviesUrl
enum MoviesUrls: URLData {
    case trending(key: String), upcoming(key: String), topRated(key: String), byGenre(key: String, genre: Int), allGenres(key: String), singleMovie(movieId: Int, key: String), addToFavorite(accoutId: Int, key: String, sessionId: String), addRating(movieId: Int, sessionId: String, key: String), searchMovie(apiKey: String, title: String), addToWatchList(accoutId: Int, apiKey: String, sessionId: String), ratedMovies(accaountId: Int, sessionId: String, apiKey: String), favoriteMovies(accaountId: Int, sessionId: String, apiKey: String), similar(movieId: Int, key: String), reviews(movieId: Int, key: String), cast(movieId: Int, key: String), moviesWithPersone(apiKey: String, personeId: Int), actorDetails(apiKey: String, actorId: Int), videos(apiKey: String, movieId: Int)
        
    var url: String {
        switch self {
        case .trending(let key):
            return "\(APIBaseURL.base.url)trending/movie/day?api_key=\(key)"
        case .upcoming(let key):
            return "\(APIBaseURL.base.url)movie/upcoming?api_key=\(key)&page=1"
        case .topRated(let key):
            return "\(APIBaseURL.base.url)movie/top_rated?api_key=\(key)&page=1"
        case .byGenre(key: let key, genre: let genre):
            return "\(APIBaseURL.base.url)discover/movie?api_key=\(key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre)"
        case .allGenres(key: let key):
            return "\(APIBaseURL.base.url)genre/movie/list?api_key=\(key)"
        case .singleMovie(movieId: let movieId, key: let key):
            return "\(APIBaseURL.base.url)movie/\(movieId)?api_key=\(key)"
        case .addToFavorite(accoutId: let accoutId, key: let key, let sessionId):
            return "\(APIBaseURL.base.url)account/\(accoutId)/favorite?api_key=\(key)&session_id=\(sessionId)"
        case .addRating(movieId: let movieId, sessionId: let sessionId, key: let key):
            return "\(APIBaseURL.base.url)movie/\(movieId)/rating?api_key=\(key)&session_id=\(sessionId)"
        case .searchMovie(apiKey: let apiKey, title: let title):
            return "\(APIBaseURL.base.url)search/movie?api_key=\(apiKey)&query=\(title)"
        case .addToWatchList(accoutId: let accoutId, apiKey: let apiKey, let sessionId):
            return "\(APIBaseURL.base.url)account/\(accoutId)/watchlist?api_key=\(apiKey)&session_id=\(sessionId)"
        case .ratedMovies(accaountId: let accaountId, sessionId: let sessionId, apiKey: let apiKey):
            return "\(APIBaseURL.base.url)account/\(accaountId)/rated/movies?api_key=\(apiKey)&session_id=\(sessionId)"
        case .favoriteMovies(accaountId: let accaountId, sessionId: let sessionId, apiKey: let apiKey):
            return "\(APIBaseURL.base.url)account/\(accaountId)/favorite/movies?api_key=\(apiKey)&session_id=\(sessionId)"
            
        case .similar(movieId: let movieId, key: let key):
            return "\(APIBaseURL.base.url)movie/\(movieId)/similar?api_key=\(key)"
        case .reviews(movieId: let movieId, key: let key):
            return "\(APIBaseURL.base.url)movie/\(movieId)/reviews?api_key=\(key)"
        case .cast(movieId: let movieId, key: let key):
            return "\(APIBaseURL.base.url)movie/\(movieId)/credits?api_key=\(key)"
        case .moviesWithPersone(apiKey: let key, personeId: let personeId):
            return "\(APIBaseURL.base.url)person/\(personeId)/movie_credits?api_key=\(key)"
        case .actorDetails(apiKey: let key, actorId: let actorId):
            return "\(APIBaseURL.base.url)person/\(actorId)?api_key=\(key)"
        case .videos(apiKey: let apiKey, movieId: let movieId):
            return "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
        }
    }
    
    var method: String {
        switch self {
        case .trending:
            return "GET"
        case .upcoming:
            return "GET"
        case .topRated:
            return "GET"
        case .byGenre:
            return "GET"
        case .allGenres:
            return "GET"
        case .singleMovie:
            return "GET"
        case .addToFavorite:
            return "POST"
        case .addRating:
            return "POST"
        case .searchMovie:
            return "GET"
        case .addToWatchList:
            return "POST"
        case .ratedMovies:
            return "GET"
        case .favoriteMovies:
            return "GET"
        case .similar:
            return "GET"
        case .reviews:
            return "GET"
        case .cast:
            return "GET"
        case .moviesWithPersone:
            return "GET"
        case .actorDetails:
            return "GET"
        case .videos:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .searchMovie:
            return [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyNDA0NzIzOS41NDk5NjIsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2dmT4RCVVSibsak5Eq4XMFeMJtY6gKGic29qmh5TePk"
              ]
        case .addRating:
            return [
                "accept": "application/json",
                "Content-Type": "application/json;charset=utf-8",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzAxOTc1NC4zOTY1MTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdySVI1EWaIw5YpFeOLP4mbv2FW37mGMs4V9gwps0r8"
              ]
        case .addToFavorite:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMzAxOTc1NC4zOTY1MTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IdySVI1EWaIw5YpFeOLP4mbv2FW37mGMs4V9gwps0r8"
              ]
        case .addToWatchList:
            return [
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDUxMmM5MTg5ZDNiYTZmZTNhMWRlNjMyNGFkNTc2YSIsIm5iZiI6MTcyMTE0NTkxMC4xMjA1MTMsInN1YiI6IjY0NTNkZWM2ZDQ4Y2VlMDBlMTMzYTA2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lcCwZRSZKtDGUo5Bri9YQ7cFZzABb07mqhKY_jt8MGg"
              ]
        default:
           return [:]
        }
    }
}
