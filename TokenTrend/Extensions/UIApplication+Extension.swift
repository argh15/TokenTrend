//
//  UIApplication+Extension.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/10/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
