//
//  Extensions.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 14.07.2024.
//

import UIKit

//Empty struct to past in to request factory function to avoid http body 
struct NoBody: Codable { }

extension String {
    var formatDateFromISO: String {
        get {
            let formater = ISO8601DateFormatter()
            formater.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let dateOfCreationg = formater.date(from: self)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "YYYY-MM-dd"
            
            return dateFormater.string(from: dateOfCreationg ?? Date())
        }
    }
}

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

extension CAGradientLayer {
    func animatedGradient() {
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.fromValue = [UIColor.black.withAlphaComponent(0.3).cgColor,
                                       UIColor.black.withAlphaComponent(0.3).cgColor,
                                       UIColor.black.withAlphaComponent(0.3).cgColor]
        gradientAnimation.toValue = [UIColor.gray.withAlphaComponent(0.3).cgColor,
                                     UIColor.gray.withAlphaComponent(0.3).cgColor,
                                     UIColor.gray.withAlphaComponent(0.3).cgColor]
        gradientAnimation.duration = 1.3
        gradientAnimation.repeatCount = .infinity
        self.add(gradientAnimation, forKey: "colorsAnimation")
    }
}
