//
//  Flowers.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
}

struct ProductsResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
