//
//  AppError.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation



enum AppError: Error, LocalizedError, Equatable {
    case badURL, badResponse, invalidData, incorrectUserNameOrPass, incorrectAccoutId, invalidStatusCode(code: Int)
    
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
        case .invalidStatusCode(code: let code):
            return "Invalid status code: \(code)"
        }
    }
}

enum KeychainError: Error {
    case duplicateEntry, unknown(OSStatus)
}
