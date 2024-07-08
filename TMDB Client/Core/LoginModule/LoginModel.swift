//
//  LoginModel.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


struct User: Codable {
    let username: String
    let password: String
    let request_token: String
}

