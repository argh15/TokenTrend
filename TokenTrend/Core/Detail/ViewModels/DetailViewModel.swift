//
//  DetailViewModel.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .sink { (coinDetails) in
                print("Coin Details Received!")
                print(coinDetails)
            }
            .store(in: &cancellables)
    }
}
