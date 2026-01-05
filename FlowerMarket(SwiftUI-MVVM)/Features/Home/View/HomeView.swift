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
                            // عرض الـ Skeleton أثناء التحميل
                            loadingSkeletonState
                        } else {
                            // عرض المحتوى الفعلي مقسم حسب التصنيفات
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
                ProductDetailsView(product: product)
            } label: {
                ProductRow(
                    product: product,
                    onFavorite: { viewModel.toggleFavorite(product) },
                    onAddToCart: { viewModel.addToCart(product) }
                )
            }
            .buttonStyle(.plain)
            .padding(.horizontal)
        }
    }
}
