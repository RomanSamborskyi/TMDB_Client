//
//  SectetDecoder.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.06.2025.
//

import Foundation


enum TMDB_KEY {
    static var key: String {
        guard let key = Bundle.main.infoDictionary!["TMDB_API_KEY"] as? String else {
            fatalError("Error of fetching API KEY, check config file")
        }
        return key
    }
}
