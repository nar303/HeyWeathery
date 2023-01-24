//
//  HapticsManager.swift
//  Amore1
//
//  Created by Ashot on 01.11.22.
//

import Foundation
import UIKit

final class HapticsManager {
    static let shared = HapticsManager()
    private init() {}
    
    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedBackGenerator = UISelectionFeedbackGenerator()
            selectionFeedBackGenerator.prepare()
            selectionFeedBackGenerator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationFeedBackGenerator = UINotificationFeedbackGenerator()
            notificationFeedBackGenerator.prepare()
            notificationFeedBackGenerator.notificationOccurred(type)
        }
    }
    
    public func impactVibrate(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let impactFeedBackGenerator = UIImpactFeedbackGenerator(style: style)
            impactFeedBackGenerator.prepare()
            impactFeedBackGenerator.impactOccurred()
        }
    }
}
