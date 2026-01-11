//
//  CartItem.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 10/01/2026.
//

import Foundation


struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
    
    var price: Double {
        product.price * (1 - Double(product.discountPercentage ?? 0) / 100)
    }
}
