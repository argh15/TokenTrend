//
//  Coin.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import Foundation

// Gecko - Coin API
/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 
 {
     "id": "leo-token",
     "symbol": "leo",
     "name": "LEO Token",
     "image": "https://assets.coingecko.com/coins/images/8418/large/leo-token.png?1696508607",
     "current_price": 5.79,
     "market_cap": 5372380209,
     "market_cap_rank": 24,
     "fully_diluted_valuation": 5711582274,
     "total_volume": 1268379,
     "high_24h": 5.82,
     "low_24h": 5.75,
     "price_change_24h": 0.0100902,
     "price_change_percentage_24h": 0.17446,
     "market_cap_change_24h": 14850394,
     "market_cap_change_percentage_24h": 0.27719,
     "circulating_supply": 926727648.9,
     "total_supply": 985239504.0,
     "max_supply": null,
     "ath": 8.14,
     "ath_change_percentage": -28.76191,
     "ath_date": "2022-02-08T17:40:10.285Z",
     "atl": 0.799859,
     "atl_change_percentage": 624.56044,
     "atl_date": "2019-12-24T15:14:35.376Z",
     "roi": null,
     "last_updated": "2024-04-08T06:42:38.453Z",
     "sparkline_in_7d": {
         "price": [
             6.051507563968339,
             6.0718675364723955
         ]
     },
     "price_change_percentage_24h_in_currency": 0.17446231430199788
 }
 
 */

// MARK: - Coin
struct Coin: Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H, circulatingSupply: Double?
    let totalSupply, maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    func updateCoinHoldings(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
