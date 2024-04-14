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
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitleView
                    Divider()
                    coinDescriptionView
                    overviewGridView
                    additionalsTitleView
                    Divider()
                    additionalsGridView
                    linksView
                }
                .padding()
            }
            
        }
        .background(
            Color.colorTheme.appBackground
        )
        .navigationTitle(vm.coin.name)
        .toolbarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navbarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: MockCoin.instance.coin)
    }
}

extension DetailView {
    
    private var navbarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.appSecondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitleView: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.accent)
    }
    
    private var overviewGridView: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat, alignment: .leading)
                }
            })
    }
    
    private var coinDescriptionView: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(.appSecondaryText)
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "Less" : "Read More ...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                    }
                    .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var additionalsTitleView: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.accent)
    }
    
    private var additionalsGridView: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat, alignment: .leading)
                }
            })
    }
    
    private var linksView: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteURL = vm.websiteURL, let url = URL(string: websiteURL) {
                Link(destination: url, label: {
                    Text("Website")
                })
            }
            
            if let subredditURL = vm.subredditURL, let url = URL(string: subredditURL) {
                Link(destination: url, label: {
                    Text("Reddit")
                })
            }
        }
        .font(.headline)
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
