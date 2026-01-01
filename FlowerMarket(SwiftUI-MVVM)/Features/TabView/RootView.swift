//
//  RootView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//

import  SwiftUI

enum Tab {
    case home
    case offers
    case profile
}

struct RootView: View {

    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .bottom) {

            // CONTENT
            Group {
                switch selectedTab {
                case .home:
                    HomeTab()
                case .offers:
                    OffersTab()
                case .profile:
                    ProfileTab()
                }
            }

            // TAB BAR
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}
