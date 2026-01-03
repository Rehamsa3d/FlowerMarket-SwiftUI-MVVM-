//
//  ProductRow.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//
import Foundation
import SwiftUI
struct ProductRow: View {
    
    let product: Product
    var onFavorite: () -> Void
    var onAddToCart: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 90, height: 90)
            .clipped()
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                
                priceView
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                
                // ❤️ Favorite
                Button(action: onFavorite) {
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                }
                .buttonStyle(.borderless)
                
                // 🛒 Add to Cart
                Button(action: onAddToCart) {
                    Image(systemName: "cart.badge.plus")
                        .foregroundColor(.blue)
                }
                .buttonStyle(.borderless)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
        .contentShape(Rectangle())
    }
    
    private var priceView: some View {
        Group {
            if let discount = product.discountPercentage {
                HStack(spacing: 6) {
                    Text("$\(product.price)")
                        .strikethrough()
                        .foregroundColor(.secondary)
                    
                    Text(discountedPrice)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            } else {
                Text("$\(product.price)")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var discountedPrice: String {
        let discounted = product.price * (1 - Double((product.discountPercentage ?? 0) / 100))
        return String(format: "$%.2f", discounted)
    }
}


