//
//  HapticFeedback.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 26.08.2024.
//

import UIKit
import CoreHaptics


class HapticFeedback {
    
    func tacticFeddback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedback = UIImpactFeedbackGenerator(style: style)
        feedback.impactOccurred()
    }
    func tacticNotification(style: UINotificationFeedbackGenerator.FeedbackType) {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(style)
    }
}
