//
//  CoinImageView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin) {
       _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.appSecondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: BTCCoin.instance.coin)
}
