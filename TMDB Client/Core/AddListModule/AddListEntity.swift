//
//  AddListEntity.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 23.08.2024.
//

import UIKit


//MARK: - CreateListResponse
struct CreateListResponse: Codable {
    let statusMessage: String
    let success: Bool
    let statusCode: Int
    let listId: Int?

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case success
        case statusCode = "status_code"
        case listId = "list_id"
    }
}
//MARK: - CreateListRequest
struct CreateListRequest: Codable {
    let name: String
    let description: String
    let language: String? = "iso_639_1"

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case language
    }
}
