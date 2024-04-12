//
//  CoinRowView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import SwiftUI

struct CoinRowView: View {
    
    var coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColoumn
            Spacer()
            if showHoldingsColumn {
                centerColoumn
            }
            rightColoumn
            
        }
        .font(.subheadline)
        // hack to make the whole row clickable
        // as of now since we have a spacer in the middle
        // the middle part of the row is NOT clickable
        .background(
            Color.theme.appBackground
        )
    }
}

#Preview ("Coin") {
    CoinRowView(coin: MockCoin.instance.coin, showHoldingsColumn: true)
}

extension CoinRowView {
    
    private var leftColoumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(.appSecondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(.accent)
        }
    }
    
    private var centerColoumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? "")
            
        }
        .foregroundStyle(.accent)
    }
    
    private var rightColoumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2To6Decimals())
                .bold()
                .foregroundStyle(.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? .appGreen : .appRed
                )
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
    
}
