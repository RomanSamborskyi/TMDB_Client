//
//  AppError.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation



enum AppError: Error, LocalizedError {
    case badURL, badResponse, invalidData, incorrectUserNameOrPass, incorrectAccoutId
    
    var localized: String {
        switch self {
        case .badURL:
            return "Bad url"
        case .badResponse:
            return "Bad response"
        case .invalidData:
            return "Invalid data"
        case .incorrectUserNameOrPass:
            return "Please check username or password"
        case .incorrectAccoutId:
            return "Incorrect accout ID"
        }
    }
}

enum KeychainError: Error {
    case duplicateEntry, unknown(OSStatus)
}
