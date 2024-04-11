//
//  Color+Extension.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/7/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let appBackground = Color("AppBackgroundColor")
    let appGreen = Color("AppGreenColor")
    let appRed = Color("AppRedColor")
    let appSecondaryText = Color("AppSecondaryTextColor")
}
