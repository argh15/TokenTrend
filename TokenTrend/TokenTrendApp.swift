//
//  TokenTrendApp.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/5/24.
//

import SwiftUI

@main
struct TokenTrendApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.accent)]
        UINavigationBar.appearance().tintColor = UIColor(.accent)
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16, macOS 13, tvOS 16, watchOS 9, visionOS 1, *) {
                // Use the latest API.
                ZStack {
                    NavigationStack {
                        HomeView()
                            .toolbar(.hidden, for: .navigationBar)
                    }
                    ZStack {
                        if showLaunchView {
                            LaunchView(showLaunchView: $showLaunchView)
                        }
                    }
                    .zIndex(2.0)
                }
            } else {
                // Support previous platform versions.
                ZStack {
                    NavigationView {
                        HomeView()
                    }
                    ZStack {
                        if showLaunchView {
                            LaunchView(showLaunchView: $showLaunchView)
                                .transition(.blurReplace)
                        }
                    }
                    .zIndex(2.0)
                }
            }
        }
        .environmentObject(vm)
    }
}
