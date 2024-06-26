//
//  SearchBarView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/10/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? .appSecondaryText : .accent)
            TextField("Search by name or symbol", text: $searchText)
                .foregroundStyle(.accent)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                        .foregroundStyle(.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    ,
                    alignment: .trailing)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.appBackground)
                .shadow(color: .accent.opacity(0.15), radius: 10))
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
