//
//  StatisticView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/10/24.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: Statistic
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(.appSecondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(.accent)
            HStack (spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.caption)
                .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? .appGreen : .appRed)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {
    Group {
        Spacer()
        StatisticView(stat: MockStatistic.instance.stat1, alignment: .leading)
        Spacer()
        StatisticView(stat: MockStatistic.instance.stat2, alignment: .center)
        Spacer()
        StatisticView(stat: MockStatistic.instance.stat3, alignment: .trailing)
        Spacer()
    }
}
