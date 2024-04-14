//
//  DetailViewModel.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coin: Coin
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var subredditURL: String? = nil
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additionals
            }
            .store(in: &cancellables)
        
        // separated sinks to keep the links and optional description separate
        coinDetailDataService.$coinDetails
            .sink { [weak self] (coinDetails) in
                self?.coinDescription = coinDetails?.readableDescription
                self?.websiteURL = coinDetails?.links?.homepage?.first
                self?.subredditURL = coinDetails?.links?.subredditUrl
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetails: CoinDetail?, coin: Coin) -> (overview: [Statistic], additionals: [Statistic]) {
        // overviewArray
        let overviewArray = self.createOverviewArray(coin: coin)
        // additionalsArray
        let additionalsArray = self.createAdditionalsArray(coin: coin, coinDetails: coinDetails)
        return (overviewArray, additionalsArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith2To6Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketStat = Statistic(title: "Market Cap", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        return [
            priceStat, marketStat, rankStat, volumeStat
        ]
    }
    
    private func createAdditionalsArray(coin: Coin, coinDetails: CoinDetail?) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith2To6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith2To6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashingAlgorithm = coinDetails?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashingAlgorithm)
        
        return [
            highStat, lowStat, priceChangeStat, marketChangeStat, blockTimeStat, hashingStat
        ]
    }
}
