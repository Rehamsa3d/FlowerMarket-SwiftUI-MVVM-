//
//  ProductCardView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI
struct ProductCard: View {
    let product: Product
    var onFavorite: () -> Void
    var onAddToCart: () -> Void
    var isFavorite: Bool
    
    @State private var isAdded = false

    var body: some View {
        VStack(spacing: 0) {
            // Image Section
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
                .padding(15)
                
                Button(action: onFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .padding(10)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                }
                .padding(10)
            }
            
            // Info Section
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 14, weight: .bold))
                    .lineLimit(1)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
            
            // The "Involved" Button - Seamlessly part of the card
            Button(action: {
                withAnimation(.spring()) {
                    isAdded = true
                    onAddToCart()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isAdded = false
                }
            }) {
                HStack {
                    Image(systemName: isAdded ? "checkmark" : "plus")
                    Text(isAdded ? "Added" : "Add to Cart")
                }
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(isAdded ? .green : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.08)) // Integrated background
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        // This creates the unified outline look
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .frame(width: 170)
    }
}
struct ProductCard0: View {
    let product: Product
    var onFavorite: () -> Void
    var onAddToCart: () -> Void
    var isFavorite: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 1. Image Section (Maintained with a slight improvement to the Heart)
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .overlay(ProgressView())
                }
                .frame(width: 160, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Button(action: onFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(isFavorite ? .red : .primary) // Red when active
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .padding(10)
                }
            }

            // 2. Info Section
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("$")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.green)
                    
                    Text("\(product.price, specifier: "%.2f")")
                        .font(.system(size: 17, weight: .heavy, design: .rounded))
                        .foregroundColor(.primary)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 4)
            
            // 3. The "Amazing" Add to Cart Button
            Button(action: onAddToCart) {
                HStack {
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: 14, weight: .bold))
                    Text("Add to Cart")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(
                    LinearGradient(
                        colors: [Color.blue, Color.blue.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            .padding(.top, 12) // Spacing between price and button
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.06), radius: 15, x: 0, y: 8)
        .frame(width: 180)
    }
}

//struct ProductCard: View {
//    let product: Product
//    var onFavorite: () -> Void
//    var onAddToCart: () -> Void
//    var isFavorite:Bool
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // 1. Image Section
//            ZStack(alignment: .topTrailing) {
//                AsyncImage(url: URL(string: product.thumbnail)) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                } placeholder: {
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.1))
//                        .overlay(ProgressView())
//                }
//                .frame(width: 160, height: 160)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                
//                Button(action: onFavorite) {
//                    Image(systemName: isFavorite ? "heart.fill" : "heart")
//                        .font(.system(size: 14, weight: .bold))
//                        .padding(8)
//                        .background(.ultraThinMaterial)
//                        .clipShape(Circle())
//                        .padding(10)
//                }
//            }
//
//            // 2. Info Section
//            VStack(alignment: .leading, spacing: 4) {
//                Text(product.title)
//                    .font(.system(size: 15, weight: .semibold, design: .rounded))
//                    .foregroundColor(.primary)
//                    .lineLimit(1)
//
//                HStack(alignment: .firstTextBaseline, spacing: 2) {
//                    Text("$")
//                        .font(.system(size: 12, weight: .bold))
//                        .foregroundColor(.green)
//                    
//                    Text("\(product.price, specifier: "%.2f")")
//                        .font(.system(size: 17, weight: .heavy, design: .rounded))
//                        .foregroundColor(.primary)
//                }
//            }
//            .padding(.top, 10)
//            .padding(.horizontal, 4)
//        }
//        .padding(10)
//        .background(Color.white)
//        .cornerRadius(24)
//        .shadow(color: Color.black.opacity(0.04), radius: 15, x: 0, y: 8)
//        .frame(width: 180)
//    }
//}
