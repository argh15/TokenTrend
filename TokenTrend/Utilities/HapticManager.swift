//
//  HapticManager.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
