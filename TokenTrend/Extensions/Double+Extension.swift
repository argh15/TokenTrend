//
//  Double+Extension.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import Foundation

extension Double {
    
    /// Converts a double value to a Currency with 2 decimal points
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // current locale - default
//        formatter.locale = .current
        // change values according to need
//        formatter.currencySymbol = "$"
//        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a double value to a Currency as a String with 2 decimal points
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double value to a Currency with 2-6 decimal points
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter26: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // current locale - default
//        formatter.locale = .current
        // change values according to need
//        formatter.currencySymbol = "$"
//        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a double value to a Currency as a String with 2-6 decimal points
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith2To6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter26.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double value to a String
    /// ```
    /// Convert 12.3456 to "12.34"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a double value to a String with %
    /// ```
    /// Convert 12.3456 to "12.34 %"
    /// ```
    func asPercentageString() -> String {
        return asNumberString() + " %"
    }
}
