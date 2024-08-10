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
extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension Notification.Name {
    static var movieAddedToWatchList: Notification.Name {
        return .init("movieAddedToWatchList")
    }
}