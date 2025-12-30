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
    let category: String
    let price: Double
    let thumbnail: String
}

struct ProductsResponse: Decodable {
    let products: [Product]
}
