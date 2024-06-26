//
//  CircleButtonView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(.appBackground))
            .shadow(
                color: .accent.opacity(0.25), radius: 10)
            .padding()
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
            .previewLayout(.sizeThatFits)
        CircleButtonView(iconName: "plus")
            .previewLayout(.sizeThatFits)
    }
    
}
