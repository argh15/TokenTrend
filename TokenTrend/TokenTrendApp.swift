//
//  TokenTrendApp.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/5/24.
//

import SwiftUI

@main
struct TokenTrendApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16, macOS 13, tvOS 16, watchOS 9, visionOS 1, *) {
                // Use the latest API.
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
            } else {
                // Support previous platform versions.
                NavigationView {
                    HomeView()
                }
            }
        }
    }
}
