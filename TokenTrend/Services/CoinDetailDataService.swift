//
//  CoinDetailDataService.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetail? = nil
    
    private var coinDetailSubscription: AnyCancellable?
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (coinDetails) in
                self?.coinDetails = coinDetails
                self?.coinDetailSubscription?.cancel()
            })

    }
}
