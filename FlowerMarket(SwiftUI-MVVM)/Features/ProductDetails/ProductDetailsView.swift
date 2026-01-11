//
//  ProductDetailsView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//


import SwiftUI

import SwiftUI

struct ProductDetailsView: View {
    
    let product: Product
    @State private var quantity: Int = 1
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favorites: FavoritesManager
    var isFavorite:Bool

//    var onFavorite: () -> Void
//    var onAddToCart: () -> Void
//    var isFavorite:Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                
                // 1. Hero Image Section
                productImage
                    .padding(.bottom, 25)
                
                VStack(alignment: .leading, spacing: 20) {
                    // 2. Title and Badge Row
                    HStack(alignment: .top) {
                        Text(product.title)
                            .font(.system(.title, design: .serif).bold())
                        Spacer()
                        if let discount = product.discountPercentage {
                            Text("-\(Int(discount))%")
                                .font(.caption.bold())
                                .padding(8)
                                .background(Color.red.opacity(0.1))
                                .foregroundColor(.red)
                                .clipShape(Capsule())
                        }
                    }
                    
                    // 3. Price
                    priceView
                    
                    // 4. Description
                    Text("About this flower")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Text(product.description ?? "Experience the beauty of nature with this exquisite selection.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(6)
                    
                    // 5. Quantity Selector
                    customQuantitySelector
                        .padding(.vertical, 10)
                }
                .padding(.horizontal, 20)
                
                // Space for bottom button
                Color.clear.frame(height: 100)
            }
        }
        .ignoresSafeArea(edges: .top)
        .safeAreaInset(edge: .bottom) {
            addToCartButton
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - Subviews
private extension ProductDetailsView {
    
    var productImage: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight], radius: 50))
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 400)
            }
            
            // Floating Favorite Button
            Button(action: addToFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .gray)
                    .foregroundColor(.red.opacity(0.8))
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .offset(x: -30, y: 25)
        }
    }

    var priceView: some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Text(discountedPrice)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            if product.discountPercentage != nil {
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .strikethrough()
                    .foregroundColor(.secondary)
            }
        }
    }

    var customQuantitySelector: some View {
        HStack {
            Text("Quantity")
                .font(.headline)
            Spacer()
            HStack(spacing: 20) {
                Button(action: { if quantity > 1 { quantity -= 1 } }) {
                    Image(systemName: "minus")
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                Text("\(quantity)")
                    .font(.title3.bold())
                    .frame(width: 30)
                Button(action: { if quantity < 10 { quantity += 1 } }) {
                    Image(systemName: "plus")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(20)
    }

    var addToCartButton: some View {
        Button(action: addToCart) {
            HStack(spacing: 15) {
                Image(systemName: "cart.fill")
                Text("Add to Cart • \(discountedPrice)")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Color.blue)
            .cornerRadius(20)
            .shadow(color: Color.blue.opacity(0.3), radius: 10, y: 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    var backButton: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .foregroundColor(.primary)
        }
    }
}

// MARK: - Helpers
struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
private extension ProductDetailsView {

    var discountedPriceValue: Double {
        product.price * (1 - Double(product.discountPercentage ?? 0) / 100)
    }

    var discountedPrice: String {
        String(format: "$%.2f", discountedPriceValue)
    }

    var totalSectionPrice: String {
        let total = discountedPriceValue * Double(quantity)
        return String(format: "$%.2f", total)
    }

    func addToCart() {

        cartManager.addToCart(product: product, quantity: quantity)
        
        // لمسة UI: اهتزاز بسيط (Haptic Feedback) عند الإضافة
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        print("Cart updated: \(cartManager.cartItems.count) items total")
    }
    
    func addToFavorite() {
        favorites.toggleFavorite(productID: product.id)
       
    }
}
