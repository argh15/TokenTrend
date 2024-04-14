//
//  ChartView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/12/24.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startDate: Date
    private let endDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: Coin) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.minY = data.min() ?? 0
        self.maxY = data.max() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .appGreen : .appRed
        
        endDate = Date(coinAPIString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxisLabels.padding(.horizontal, 4), alignment: .leading)
            chartXAxisLabels.padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundStyle(.appSecondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 1.5)) {
                    percentage = 1.0
                }
            }
        }
    }
        
}

#Preview {
    ChartView(coin: MockCoin.instance.coin)
}


extension ChartView {
    
    // xPosition -------
    // 300 -> width of the screen
    // 100 -> data count
    // 300 / 100 = 3
    // (0 + 1) -> 1st index
    // xPosition = 3
    // (1 + 1) -> 2nd index
    // xPosition = 6
    // (2 + 1) -> 3rd index
    // xPosition = 9
    
    // yPosition -------
    // eg - BTC
    // max - 60,000
    // min - 50,000
    // yAxis = 60,000 - 50,000 = 10,000
    // data point -> 52,000
    // 52,000 - 50,000 = 2,000
    // 2,000 / 10,000 = 0.2/20%
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = (geometry.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    // subtract from 1 because iPhone coordinate system - 0,0 is at top and not at bottom, so we reverse it
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .clipped()
            .shadow(color: lineColor.opacity(1), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 30)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxisLabels: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartXAxisLabels: some View {
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}
