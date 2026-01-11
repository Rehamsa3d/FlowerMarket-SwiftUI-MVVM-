//
//  CartManager.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 04/01/2026.
//


import Foundation
 import Combine
 import SwiftUI

class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
   // @Published private(set) var items: [Product] = []
        
//    @Published private(set) var favoriteIDs: Set<Int> = [] // Stores IDs of favorite products
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    func addToCart(product: Product, quantity:Int? = 1) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity ?? 1
        } else {
            let newItem = CartItem(product: product, quantity: quantity ?? 1)
            cartItems.append(newItem)
        }
    }
}


extension CartManager {
    func removeFromCart(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
    
    func updateQuantity(for item: CartItem, delta: Int) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            let newQuantity = cartItems[index].quantity + delta
            if newQuantity > 0 {
                cartItems[index].quantity = newQuantity
            }
        }
    }
}
