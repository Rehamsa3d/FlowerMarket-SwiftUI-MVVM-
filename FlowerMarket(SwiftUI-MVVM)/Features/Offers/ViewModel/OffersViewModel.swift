//
//  OffersViewModel.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 03/01/2026.
//


import Foundation
 import Combine

@MainActor
final class OffersViewModel: ObservableObject {

    // MARK: - UI State
    @Published var searchText: String = ""
    @Published var filteredProducts: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Data State
    @Published private(set) var allProducts: [Product] = []
    @Published private(set) var favorites: Set<Int> = []
    @Published private(set) var cart: [Product] = []

    // MARK: - Dependencies
    private let service: ProductsService
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(service: ProductsService = RemoteProductsService()) {
        self.service = service
        setupSearchDebounce()
    }

    // MARK: - Data Loading
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let products = try await service.fetchProducts()
            allProducts = products
            filteredProducts = products
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Favorites
    func toggleFavorite(_ product: Product) {
        if favorites.contains(product.id) {
            favorites.remove(product.id)
        } else {
            favorites.insert(product.id)
        }
    }

    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(product.id)
    }

    // MARK: - Cart
    func addToCart(_ product: Product) {
        cart.append(product)
    }

    func cartCount() -> Int {
        cart.count
    }

    func openCart() {
        print("Cart opened with \(cart.count) items")
    }
}

private extension OffersViewModel {

    func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterProducts(with: text)
            }
            .store(in: &cancellables)
    }

    func filterProducts(with text: String) {
        guard !text.isEmpty else {
            filteredProducts = allProducts
            return
        }

        filteredProducts = allProducts.filter {
            $0.title.localizedCaseInsensitiveContains(text)
        }
    }
}


extension OffersViewModel {

    var productsByCategory: [String: [Product]] {
        Dictionary(grouping: filteredProducts, by: \.category)
    }

    var sortedCategories: [String] {
        productsByCategory.keys.sorted()
    }
}
