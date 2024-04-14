//
//  HomeViewModel.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import Foundation
import Combine

public enum SortOptions {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
}

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var statistics: [Statistic] = []
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOptions = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // updates allCoins -> fetches and filters
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates portfolio data
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map (mapGlobalMarketData)
            .sink { [weak self] (returnedMarketData) in
                self?.statistics = returnedMarketData
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePorfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getAllCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOptions) -> [Coin] {
        // filter coins
        var updatedCoins = filterCoins(text: text, coins: coins)
        // sort coins
        sortCoins(coins: &updatedCoins, sort: sort)
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(coins: inout [Coin], sort: SortOptions) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioItem]) -> [Coin] {
        allCoins.compactMap { (coin) -> Coin? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
            return coin.updateCoinHoldings(amount: entity.amount)
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        // will only sort by holdings or holdingsReversed if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else { return stats }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        
        let currentValue = getPortfolioCurrentValue(portfolioCoins: portfolioCoins)
        let value24HoursBack = getPortfolio24HPreviousValue(portfolioCoins: portfolioCoins)
        var percentChange = ((currentValue - value24HoursBack) / value24HoursBack)
        if percentChange.isNaN {
            percentChange = 0.0
        }
        
        let portfolioValue = Statistic(title: "Portfolio Value", value: currentValue.formattedWithAbbreviations(), percentageChange: percentChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolioValue
        ])
        
        return stats
    }
    
    private func getPortfolioCurrentValue(portfolioCoins: [Coin]) -> Double {
        return portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
    }
    
    private func getPortfolio24HPreviousValue(portfolioCoins: [Coin]) -> Double {
        return portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let change24Hours = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + change24Hours)
                return previousValue
            }
            .reduce(0, +)
    }
}
