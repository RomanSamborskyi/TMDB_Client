//
//  NotificationCenterManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 17.10.2024.
//

import UIKit
import NotificationCenter

class NotificationCenterManager {
    
    static let instance: NotificationCenterManager = NotificationCenterManager()
    
    private init() { }
    
    private let notificationCenter = NotificationCenter.default
    
    func addObserverver(observer: Any, selector: Selector, name: Notification.Name?, object: Any?) {
        notificationCenter.addObserver(observer, selector: selector, name: name, object: object)
    }
    func removeAllObservers(_ observer: Any) {
        notificationCenter.removeObserver(observer)
    }
    func removeSpecificObserver(_ target: Any, name: Notification.Name, object: Any?) {
        notificationCenter.removeObserver(target, name: name, object: object)
    }
}
