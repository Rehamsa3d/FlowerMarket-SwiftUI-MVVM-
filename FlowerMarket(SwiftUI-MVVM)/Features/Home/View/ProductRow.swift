//
//  ProductRow.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//
import SwiftUI

struct ProductRow: View {
    let product: Product
    var onFavorite: () -> Void
    var onAddToCart: () -> Void
    var isFavorite:Bool
    
    
    var body: some View {
        HStack(spacing: 16) {
            // 1. Image with Discount Badge
            ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20)) 
                
                if let discount = product.discountPercentage, discount > 0 {
                    Text("\(Int(discount))% OFF")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .offset(x: -5, y: -5)
                }
            }
            
            // 2. Product Info
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                
                priceView
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundColor(.orange)
                    Text("4.8")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // 3. Actions
            VStack(spacing: 15) {
                Button(action: onFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorite ? .red : .gray)
                        .foregroundColor(.red.opacity(0.8))
                }
                
                Button(action: onAddToCart) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
    }
    
    private var priceView: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let discount = product.discountPercentage, discount > 0 {
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.caption)
                    .strikethrough()
                    .foregroundColor(.secondary)
                
                Text(discountedPrice)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
            } else {
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
            }
        }
    }
    
    private var discountedPrice: String {
        let discounted = product.price * (1 - Double((product.discountPercentage ?? 0) / 100))
        return String(format: "$%.2f", discounted)
    }
}
