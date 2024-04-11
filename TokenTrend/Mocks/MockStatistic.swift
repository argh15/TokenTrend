//
//  MockStatistic.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/10/24.
//

import Foundation

class MockStatistic {
    
    static let instance = MockStatistic()
    
    private init() { }
    
    let stat1 = Statistic(title: "Market Cap", value: "$112.5Bn", percentageChange: 25.76)
    let stat2 = Statistic(title: "Total Volume", value: "$12.5Mn")
    let stat3 = Statistic(title: "Portfolio Value", value: "$112.5Bn", percentageChange: -25.76)


}
