//
//  HomeBannerView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI
struct HomeBannerView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("Discover Products")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                Text("Best deals curated for you")
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding()
        }
        .frame(height: 140)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}
