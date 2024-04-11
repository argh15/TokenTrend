//
//  MarketDataService.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/11/24.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketData? = nil
    
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })

    }
}
