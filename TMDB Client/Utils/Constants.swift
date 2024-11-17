//
//  Constants.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import UIKit


struct Constants {
    
    static let account_id: String = "account_id"
    static let access_token: String = "access_token"
    static let sessionKey: String = "session_id"
    static let officialTrailer: String = "Official Trailer"
    static let apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? "NO KEY"
    
}


