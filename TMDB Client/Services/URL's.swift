//
//  URL's.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation


enum Authantication {
    case token_request(key: String), session_with_login(key: String)
    
    var url: String {
        switch self {
        case .token_request(let key):
            return "https://api.themoviedb.org/3/authentication/token/new?api_key=\(key)"
        case .session_with_login(let key):
            return "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(key)"
        }
    }
}

