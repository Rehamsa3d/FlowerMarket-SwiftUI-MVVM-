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
    let onFavorite: (Product) -> Void
    let onAddToCart: (Product) -> Void

    var body: some View {

        // Empty state
        if products.isEmpty {
            ContentUnavailableView(
                "No Results",
                systemImage: "magnifyingglass",
                description: Text("Try searching with a different keyword.")
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {

            // Flat results list
            LazyVStack(spacing: 16) {
                ForEach(products) { product in
                    //ProductRow(product: product)
                    ProductRow(
                        product: product,
                        onFavorite: {
                            onFavorite(product)
                        },
                        onAddToCart: {
                            onAddToCart(product)
                        }
                    )

                }
            }
            .padding(.horizontal)
        }
        
    }
}
