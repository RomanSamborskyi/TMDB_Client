//
//  Enums.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 30.11.2024.
//

import Foundation


enum TopTabs: String, CaseIterable {
    case trending, topRated, upcoming
    
    var description: String {
        switch self {
        case .trending:
            return "Trending"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

enum LoadingState: CaseIterable {
    case loading, loaded, empty
}

enum SearchState {
    case started, ended
}
