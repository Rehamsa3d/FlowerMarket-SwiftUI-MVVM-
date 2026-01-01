//
//  SearchResultsView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//


import SwiftUI

/// Displays flat list of products matching search criteria
struct SearchResultsView: View {

    let products: [Product]

    var body: some View {

        // Empty state
        if products.isEmpty {
            ContentUnavailableView(
                "No Results",
                systemImage: "magnifyingglass",
                description: Text("Try searching with a different keyword.")
            )
        } else {

            // Flat results list
            LazyVStack(spacing: 16) {
                ForEach(products) { product in
                    ProductRow(product: product)
                }
            }
            .padding(.horizontal)
        }
    }
}
