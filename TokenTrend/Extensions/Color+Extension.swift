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
    let background = Color("AppBackgroundColor")
    let green = Color("AppGreenColor")
    let red = Color("AppRedColor")
    let secondaryText = Color("AppSecondaryTextColor")
}
