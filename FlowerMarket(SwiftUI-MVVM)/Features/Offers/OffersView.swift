//
//  OffersView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//

import SwiftUI

struct OffersView: View {

    @StateObject private var viewModel = ProductsViewModel()

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            // MARK: - Header
            HStack {
                Text("Offers")
                    .font(.title.bold())

                Spacer()

                Button {
                    // Open Cart
                } label: {
                    Image(systemName: "cart")
                        .font(.title3)
                        .padding(8)
                        .background(Circle().fill(.ultraThinMaterial))
                }
            }

            // MARK: - Search
            SearchBar(text: $viewModel.searchText)

            // MARK: - Content
            Group {

                // 🔄 Loading state
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                // 📭 Empty state
                } else if viewModel.filteredProducts.isEmpty {
                    emptyStateView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                // 📦 Offers list
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredProducts) { product in
                                ProductRow(product: product)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
        }
        .padding(.horizontal)
        .task {
            await viewModel.loadProducts()
        }
    }

    // MARK: - Empty State View
    private var emptyStateView: some View {
        ContentUnavailableView(
            "No Offers Found",
            systemImage: "tag.slash",
            description: Text("Try searching with a different keyword or check back later.")
        )
    }
}
