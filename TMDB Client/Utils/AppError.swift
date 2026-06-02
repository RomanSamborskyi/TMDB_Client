//
//  AppError.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 09.07.2024.
//

import UIKit


protocol AlertRepresentable: AnyObject {
    func showErrorAlert(message: String, image name: String, title text: String)
}
//MARK: - Error handler protocol, to display errors to user
protocol ErrorHandler: AnyObject {
    var viewPresentable: AlertRepresentable? { get }
    func errorHandler(error: any Error)
}
extension ErrorHandler {
    func errorHandler(error: any Error) {
        if let error = error as? URLError {
            switch error.code {
            case .notConnectedToInternet:
                self.viewPresentable?.showErrorAlert(message: error.localizedDescription, image: Constants.noWiFiIcon, title: Constants.noIternetError)
            default:
                self.viewPresentable?.showErrorAlert(message: error.localizedDescription, image: Constants.unexpectedErrorIcon, title: Constants.unexpectedErrorTitle)
            }
        } else if let error = error as? AppError {
            self.viewPresentable?.showErrorAlert(message: error.localizedDescription, image: Constants.unexpectedErrorIcon, title: Constants.unexpectedErrorTitle)
        }
    }
}

//MARK: - custom app errors
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
//MARK: - keychain errors
enum KeychainError: Error {
    case duplicateEntry, unknown(OSStatus)
}
