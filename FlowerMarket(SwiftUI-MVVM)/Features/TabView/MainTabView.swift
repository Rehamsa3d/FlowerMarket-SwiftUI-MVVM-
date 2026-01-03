//
//  CustomTabBar.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//
import SwiftUI
//
enum Tab {
    case home
    case offers
    case profile
}


struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Screen
            NavigationStack {HomeView()}
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)


            // Offers Screen
            NavigationStack {OffersView()}
                .tabItem {
                    Label("Offers", systemImage: "tag")
                }
                .tag(Tab.offers)

            // Profile Screen
            NavigationStack {ProfileView()}
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)

        }
        // This makes the tab bar background look modern/translucent
        .toolbarBackground(.visible, for: .tabBar)
        .transition(.move(edge: .bottom))

        .toolbarColorScheme(.dark, for: .tabBar) // Force dark mode for tab bar
        .toolbarBackground(Color.white, for: .tabBar) // Solid color background
    }
}
