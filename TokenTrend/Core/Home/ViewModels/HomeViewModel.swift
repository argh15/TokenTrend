//
//  HomeViewModel.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText: String = ""
    
    @Published var statistics: [Statistic] = []
    
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // updates allCoins -> fetches and filters
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates market data
        marketDataService.$marketData
            .map (mapGlobalMarketData)
            .sink { [weak self] (returnedMarketData) in
                self?.statistics = returnedMarketData
            }
            .store(in: &cancellables)
        
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else { return stats }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0.00)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolioValue
        ])
        
        return stats
    }
}
