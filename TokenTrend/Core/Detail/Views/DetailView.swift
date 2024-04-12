//
//  DetailView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @State private var vm: DetailViewModel
    
    init(coin: Coin) {
        _vm = State(wrappedValue: DetailViewModel(coin: coin))
        print("Initialising Detail View with: \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: MockCoin.instance.coin)
}
