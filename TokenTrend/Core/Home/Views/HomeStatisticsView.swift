//
//  HomeStatisticsView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/10/24.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
            HStack {
                ForEach(vm.statistics) { stat in
                    StatisticView(stat: stat, alignment: .center)
                    // this way is not recommended
                    // have to change the methodology
                    // reason to use 3.1 and not 3 -
                    // using 3 has a more skewed view
                        .frame(width: UIScreen.main.bounds.width / 3.1)
                }
            }
            .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
        }
}

#Preview {
    HomeStatisticsView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
