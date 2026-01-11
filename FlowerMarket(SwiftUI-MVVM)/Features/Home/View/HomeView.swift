//
//  HomeView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//


/// Home screen of the app
/// - Shows categories by default
/// - Switches to search results when user starts typing
/// - Exposes Cart as a global action via toolbar
///
///
///
import SwiftUI
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProductsViewModel()
    @State private var showCart = false
    @State private var quantity: Int = 1

    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favorites: FavoritesManager

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Header
            headerView
            
            ScrollView {
                LazyVStack(spacing: 24) {
                    
                    if viewModel.searchText.isEmpty {
                        // MARK: - Default Home Content
                        HomeBannerView()
                        
                        if viewModel.isLoading {
                            loadingSkeletonState
                        } else {
                            categoriesSections
                        }
                        
                    } else {
                        // MARK: - Search Results
                        searchResultsList
                    }
                }
                .padding(.vertical)
            }
        }
        .task {
            await viewModel.loadProducts()
        }
        .sheet(isPresented: $showCart) {
             CartView()
        }
    }
}

// MARK: - View Components
extension HomeView {
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Flower Market")
                    .font(.system(.title, design: .serif).bold())
                
                Spacer()
                
                Button {
                    showCart = true
                } label: {
                    Image(systemName: "cart")
                        .font(.title3)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                }
                if cartManager.cartItems.count > 0 {
                                    Text("\(cartManager.cartItems.count)")
                                        .font(.caption2.bold())
                                        .foregroundColor(.white)
                                        .frame(width: 18, height: 18)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        // Offset to sit on the "shoulder" of the icon
                                        .offset(x: 5, y: -5)
                                        .transition(.scale) // Cool pop-in effect
                                }
            }
            
            SearchBar(text: $viewModel.searchText)
        }
        .padding()
    }
    
    private var loadingSkeletonState: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Loading Flowers...")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { _ in
                        ProductCardSkeleton()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var categoriesSections: some View {
        ForEach(viewModel.sortedCategories, id: \.self) { category in
            if let products = viewModel.productsByCategory[category] {
                CategorySectionView(
                    category: category,
                    products: products
                )
            }
        }
    }
    
    private var searchResultsList: some View {
        ForEach(viewModel.filteredProducts) { product in
            NavigationLink {
                ProductDetailsView(product: product, isFavorite: favorites.favoriteIDs.contains(product.id))
            } label: {
                ProductRow(
                    product: product,
                    onFavorite: {
                        favorites.toggleFavorite(productID: product.id)
                    },
                    onAddToCart: {
                        cartManager.addToCart(product: product, quantity: quantity)
                    }, isFavorite: favorites.favoriteIDs.contains(product.id)
                )
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
        }
    }
}
