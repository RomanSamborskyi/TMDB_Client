//
//  NotificationCentrManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 19.07.2024.
//

import UIKit
import NotificationCenter


class NotificationCenterManager {
    
    static let instance = NotificationCenterManager()
    private init() {  }
    
    
    
}

extension Notification.Name {
    static var movieAddedToWatchList: Notification.Name {
        return .init("movieAddedToWatchList")
    }
}
