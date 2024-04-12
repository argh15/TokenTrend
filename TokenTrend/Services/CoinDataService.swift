//
//  CoinDataService.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    
    private var coinSubscription: AnyCancellable?
    
    init() {
        getAllCoins()
    }
    
    func getAllCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })

    }
}
