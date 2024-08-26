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
    static var movieAddedToList: Notification.Name {
        return .init("movieAddedToList")
    }
    static var listAdded: Notification.Name {
        return .init("listAdded")
    }
}

extension UIViewController {
    public func showAlert(title: String, messege: String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
