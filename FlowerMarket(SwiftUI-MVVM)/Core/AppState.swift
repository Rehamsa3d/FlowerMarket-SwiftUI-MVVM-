//
//  AppState.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 29/12/2025.
//

import Foundation
internal import Combine

@MainActor
class AppState: ObservableObject {
    
    enum Phase {
        case loading
        case ready([Products])
        case error(String)
    }

    @Published var phase: Phase = .loading

   private let service: ProductsService

    init(service: ProductsService = RemoteProductsService()) {
        self.service = service
    }

    func bootstrap() async {
        do {
            let products = try await service.fetchProducts()
            phase = .ready(products)
        } catch {
            phase = .error("Failed to load data")
        }
    }

}

