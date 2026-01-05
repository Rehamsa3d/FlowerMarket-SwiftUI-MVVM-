//
//  CartView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 04/01/2026.
//


import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if cartManager.cartItems.isEmpty {
                    emptyCartState
                } else {
                    List {
                        ForEach(cartManager.cartItems) { item in
                            CartItemRow(item: item)
                        }
                        .onDelete(perform: cartManager.removeFromCart) // إضافة ميزة المسح بالسحب
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    
                    checkoutSection
                }
            }
            .navigationTitle("My Cart")
        }
    }
}
private extension CartView {
    var checkoutSection: some View {
        VStack(spacing: 20) {
            Divider()
            HStack {
                Text("Total Amount")
                    .font(.headline)
                Spacer()
                Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                    .font(.title2.bold())
                    .foregroundColor(.green)
            }
            .padding(.horizontal)
            
            Button(action: { /* Navigate to Payment */ }) {
                Text("Proceed to Checkout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
        .background(.ultraThinMaterial)
    }
    
    var emptyCartState: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.badge.minus")
                .font(.system(size: 80))
                .foregroundColor(.gray.opacity(0.4))
            Text("Your cart is empty")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
}
