//
//  FlowersViewModel.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//


import Foundation
internal import Combine

//@MainActor
//final class ProductsViewModel: ObservableObject {
//
//    @Published var products: [Product] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//
//    private let service: ProductsService
//
//    init(service: ProductsService = RemoteProductsService()) {
//        self.service = service
//    }
//
//    func loadProducts() async {
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            products = try await service.fetchProducts()
//        } catch {
//            errorMessage = "Failed to load products"
//        }
//
//        isLoading = false
//    }
//}


@MainActor
final class ProductsViewModel: ObservableObject {

    @Published var products: [Product] = []
    @Published var searchText: String = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: ProductsService

    init(service: ProductsService = RemoteProductsService()) {
        self.service = service
    }

    var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return products }

        return products.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    func loadProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            products = try await service.fetchProducts()
        } catch {
            errorMessage = "Failed to load products"
        }

        isLoading = false
    }
}

extension ProductsViewModel {

    var productsByCategory: [String: [Product]] {
        Dictionary(grouping: products, by: \.category)
    }

    var sortedCategories: [String] {
        productsByCategory.keys.sorted()
    }
}
