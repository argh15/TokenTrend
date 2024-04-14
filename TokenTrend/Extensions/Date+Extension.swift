//
//  Date+Extension.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import Foundation

extension Date {
    
    // 2013-07-06T00:00:00.000Z
    init(coinAPIString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinAPIString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
