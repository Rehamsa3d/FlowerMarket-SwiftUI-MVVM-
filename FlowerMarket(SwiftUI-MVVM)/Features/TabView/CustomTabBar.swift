//
//  CustomTabBar.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//
import SwiftUI

struct CustomTabBar: View {

    @Binding var selectedTab: Tab

    var body: some View {
        HStack {

            tabButton(.home, icon: "house", title: "Home")
            tabButton(.offers, icon: "tag", title: "Offers")
            tabButton(.profile, icon: "person", title: "Profile")

        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)

        // ✅ ADD IT HERE 👇
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.08), radius: 10)
        .frame(height: 60)

        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    func tabButton(_ tab: Tab, icon: String, title: String) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(
                selectedTab == tab ? .blue : .gray
            )
        }
        .frame(maxWidth: .infinity)
    }
}
