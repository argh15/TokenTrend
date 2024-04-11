//
//  CircleButtonViewAnimation.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import SwiftUI

struct CircleButtonViewAnimation: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
        // we could the value property here but, we don't need the animation for both values
            .animation(animate ? .easeOut : .none, value: UUID())
    }
}

#Preview {
    CircleButtonViewAnimation(animate: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 50, height: 50)
}
