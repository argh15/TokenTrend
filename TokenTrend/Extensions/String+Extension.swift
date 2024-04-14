//
//  String+Extension.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/13/24.
//

import Foundation

extension String {
    
    var removeHTMLOccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
