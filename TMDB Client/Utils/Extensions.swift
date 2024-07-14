//
//  Extensions.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit


extension Double {
    var twoCharacktersStrings: String {
        get  {
            String(format: "%.1f", self as CVarArg)
        }
    }
}
