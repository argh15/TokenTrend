//
//  SettingsView.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/13/24.
//

import SwiftUI

struct SettingsView: View {
    
    // force-unwrapping urls here because we are sure of these urls
    let defaultURL = URL(string: "https://www.google.com/")!
    let swiftfulURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com/en/api")!
    let githubURL = URL(string: "https://github.com/argh15")!
    let linkedInURL = URL(string: "https://www.linkedin.com/in/argh-chakraborty/")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.appBackground
                    .ignoresSafeArea()
                
                // content
                List {
                    swiftfulThinkingSectionView
                        .listRowBackground(Color.colorTheme.appSectionList)
                    coinGeckoSectionView
                        .listRowBackground(Color.colorTheme.appSectionList)
                    developerSectionView
                        .listRowBackground(Color.colorTheme.appSectionList)
                    applicationSectionView
                        .listRowBackground(Color.colorTheme.appSectionList)
                }
            }
            // use this for ZStack color to reflect
            .scrollContentBackground(.hidden)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButtonView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var swiftfulThinkingSectionView: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is inspired from a @SwiftfulThinking video series. It uses MVVM Architecture, Combine, and CoreData. \nA version 2.0 of this app is coming soon! 🚀")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.top)
            Link(destination: swiftfulURL) {
                Text("Subscribe to Nick's Channel!")
            }
            .foregroundStyle(.blue)
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoSectionView: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The free cryptocurrency API used in the app is from CoinGecko! The prices may be slightly delayed. 🦎")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.top)
            Link(destination: coinGeckoURL) {
                Text("Visit CoinGecko!")
            }
            .foregroundStyle(.blue)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSectionView: some View {
        Section {
            VStack(alignment: .leading) {
                Image("headshot")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Arghadeep (Argh). This app aims to solidify the concepts of SwiftUI and Combine. It uses multi-threading, animations, publishers/subscribers, and data persistence.\nIt was a lot of fun exploring these concepts. I'll be soon rolling out a new version of this app.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.top)
            Link(destination: githubURL) {
                Text("Visit My Github! 🧑‍💻")
            }
            .foregroundStyle(.blue)
            Link(destination: linkedInURL) {
                Text("Visit My LinkedIn! 👔")
            }
            .foregroundStyle(.blue)
        } header: {
            Text("Developer")
        }
    }
    
    private var applicationSectionView: some View {
        Section {
            Link(destination: defaultURL) {
                Text("Terms of Service")
            }
            .foregroundStyle(.blue)
            Link(destination: defaultURL) {
                Text("Privacy Policy")
            }
            .foregroundStyle(.blue)
            Link(destination: linkedInURL) {
                Text("Contact")
            }
            .foregroundStyle(.blue)
        } header: {
            Text("Application")
        }
    }
}
