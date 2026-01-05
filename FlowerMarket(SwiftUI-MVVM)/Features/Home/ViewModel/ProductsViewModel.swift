//
//  FlowersViewModel.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//


import Foundation
 import Combine
@MainActor
final class ProductsViewModel: ObservableObject {

    // MARK: - Published State (UI)
    @Published var searchText: String = ""
    @Published var filteredProducts: [Product] = []
    @Published var isLoading: Bool = false

    @Published var errorMessage: String?

    // MARK: - Private State
    @Published private(set) var allProducts: [Product] = []
    @Published private(set) var favorites: Set<Int> = []
    @Published private(set) var cart: [Product] = []
    
    
    private let service: ProductsService
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(service: ProductsService = RemoteProductsService()) {
        self.service = service
        setupSearchDebounce()
    }

    // MARK: - Public API
    func loadProducts() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let products = try await service.fetchProducts()
            allProducts = products
            filteredProducts = products
        } catch {
            errorMessage = error.localizedDescription
        }
    }


    // MARK: - Search Logic (Combine)
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterProducts(with: text)
            }
            .store(in: &cancellables)
    }

    private func filterProducts(with text: String) {
        guard !text.isEmpty else {
            filteredProducts = allProducts
            return
        }

        filteredProducts = allProducts.filter {
            $0.title.localizedCaseInsensitiveContains(text)
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
extension ProductsViewModel {

    var productsByCategory: [String: [Product]] {
        Dictionary(grouping: filteredProducts, by: \.category)
    }

    var sortedCategories: [String] {
        productsByCategory.keys.sorted()
    }
}

