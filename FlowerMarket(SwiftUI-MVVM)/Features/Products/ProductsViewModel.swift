//
//  FlowersViewModel.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//


import Foundation
internal import Combine
@MainActor

class ProductsViewModel: ObservableObject {

    
    @Published var product: [Products] = []
    @Published var isLoading = false
    @Published var errorMessage:String? = nil
        
    private let service: ProductsService

    init(service: ProductsService = RemoteProductsService()) {
        self.service = service
    }

    func loadProduct() {
        Task{
            isLoading = true
            errorMessage = nil
            //state = .loading
            do {
                let fetchedProducts = try await service.fetchProducts()
                product = fetchedProducts
            } catch {
                errorMessage = "Failed to load users"
            }
            isLoading = false
        }
    }

}

