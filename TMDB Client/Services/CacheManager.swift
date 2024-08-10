//
//  CacheManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


class CacheManager {
    
   static let instance = CacheManager()
   private init() { }
    
    var cache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 1024 * 1024 * 1024 * 50
        cache.totalCostLimit = 50
        return cache
    }()
    
    func add(image: UIImage, with key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    func getImage(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
