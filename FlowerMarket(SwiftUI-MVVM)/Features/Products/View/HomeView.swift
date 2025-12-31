//
//  HomeView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI
//
struct HomeView: View {

    @StateObject private var viewModel = ProductsViewModel()

    var body: some View {
        NavigationStack {
         //   SearchBar(text: $viewModel.searchText)
         

            ScrollView {
                    
                HomeBannerView()

                VStack(spacing: 24) {
                    ForEach(viewModel.sortedCategories, id: \.self) { category in
                        if let products = viewModel.productsByCategory[category] {
                            CategorySectionView(
                                category: category,
                                products: products
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Flower Market")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search flowers"
            )
            
                    }
        .task {
            await viewModel.loadProducts()
        }
    }
}
