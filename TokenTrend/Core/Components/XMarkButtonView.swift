//
//  XMarkButtonView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/11/24.
//

import SwiftUI

struct XMarkButtonView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButtonView()
}
