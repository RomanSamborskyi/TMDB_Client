//
//  MovieDetailsEntities.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 16.07.2024.
//

import Foundation


struct AddToWatchlist: Codable {
   let media_type: String
   let media_id: Int
   let watchlist: Bool
}
