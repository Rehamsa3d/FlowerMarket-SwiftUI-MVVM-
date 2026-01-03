//
//  OffersView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//

import SwiftUI

import SwiftUI

struct OffersView: View {

    @StateObject private var viewModel = OffersViewModel()
    //@Binding var showTabBar: Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {

                    // MARK: - Header
                    header

                    // MARK: - Search
                    SearchBar(text: $viewModel.searchText)

                    // MARK: - Content
                    content
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .task {
                await viewModel.loadProducts()
            }
            
        }
 

    }
    
}



private extension OffersView {
    var header: some View {
        HStack {
            Text("Offers")
                .font(.title.bold())

            Spacer()

            Button {
                viewModel.openCart()
            } label: {
                Image(systemName: "cart")
                    .font(.title3)
                    .padding(8)
                    .background(Circle().fill(.ultraThinMaterial))
            }
        }
        .padding(.top)
        
    }
}


private extension OffersView {
    @ViewBuilder
    var content: some View {

        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.top, 40)

        } else if viewModel.filteredProducts.isEmpty {
            emptyStateView
                .padding(.top, 40)

        } else {
            productsList
            
        }
        
        
    }
}


private extension OffersView {
    var productsList: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.filteredProducts) { product in
                NavigationLink {
                    ProductDetailsView(product: product)
                } label: {
                    ProductRow(
                        product: product,
                        onFavorite: {
                            viewModel.toggleFavorite(product)
                        },
                        onAddToCart: {
                            viewModel.addToCart(product)
                        }
                    )
                }
                .buttonStyle(.plain)
  
            }
        }
    }
}


private extension OffersView {
    var emptyStateView: some View {
        ContentUnavailableView(
            "No Offers Found",
            systemImage: "tag.slash",
            description: Text("Try searching with a different keyword or check back later.")
        )
    }
}
