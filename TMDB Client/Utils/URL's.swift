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
    case accDetail(key: String, sessionId: String)
    
    var url: String {
        switch self {
        case .accDetail(let key, let sessionId):
            return "https://api.themoviedb.org/3/account?api_key=\(key)&session_id=\(sessionId)"
        }
    }
}

