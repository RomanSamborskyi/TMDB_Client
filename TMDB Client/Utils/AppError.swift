//
//  AppError.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import Foundation



enum AppError: Error, LocalizedError {
    case badURL, badResponse, invalidData, incorrectUserNameOrPass, incorrectAccoutId
}

enum KeychainError: Error {
    case duplicateEntry, unknown(OSStatus)
}
