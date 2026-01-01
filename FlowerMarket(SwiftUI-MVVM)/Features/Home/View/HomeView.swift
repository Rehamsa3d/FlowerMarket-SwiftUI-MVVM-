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

struct HomeView: View {

    /// Owns the ProductsViewModel lifecycle for this screen
    @StateObject private var viewModel = ProductsViewModel()

    /// Controls Cart presentation
    @State private var showCart = false

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {
                // MARK: - Navigation
                Text("hello")
                    .font(.title.bold())

                Spacer()
                
                // MARK: - Toolbar
                Button {
                    showCart = true
                } label: {
                    Image(systemName: "cart")
                }

            }

            // Search
            SearchBar(text: $viewModel.searchText)
        }
        .padding(.horizontal)

        // Scrollable content container
        ScrollView {
            // Lazy stack for better performance with large lists
            LazyVStack(spacing: 24) {

                // MARK: - Conditional Content
                // Show categories when not searching
                if viewModel.searchText.isEmpty {

                    // Top promotional banner
                    HomeBannerView()
                    
                    // Category-based browsing UI
                    ForEach(viewModel.sortedCategories, id: \.self) { category in
                        if let products = viewModel.productsByCategory[category] {

                            CategorySectionView(
                                category: category,
                                products: products
                            )
                        }
                    }

                } else {

                    // Flat list of search results
                    SearchResultsView(
                        products: viewModel.filteredProducts
                    )
                }
            }
            .padding(.vertical)
        }

        // MARK: - Navigation
      //  .navigationTitle("Flower Market")

//        // Native iOS search experience
//        .searchable(
//            text: $viewModel.searchText,
//            placement: .navigationBarDrawer(displayMode: .always),
//            prompt: "Search flowers"
//        )


        // MARK: - Cart Presentation
        // Presented as a sheet for fast access and dismissal
//        .sheet(isPresented: $showCart) {
//           // CartView()
//        }

        // MARK: - Data Loading
        // Loads products once when the view appears
        .task {
            await viewModel.loadProducts()
        }
    }
}
