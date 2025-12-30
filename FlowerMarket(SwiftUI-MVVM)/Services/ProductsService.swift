//
//ProductsService.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import Foundation

protocol ProductsService {
    func fetchProducts() async throws -> [Product]
}
struct RemoteProductsService: ProductsService {


    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products")!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        // Decode wrapper object
        let decoded = try JSONDecoder().decode(ProductsResponse.self, from: data)
        return decoded.products
    }

}

