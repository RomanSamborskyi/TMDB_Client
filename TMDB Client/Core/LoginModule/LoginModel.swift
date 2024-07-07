//
//  LoginModel.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit


struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let password: String
}
