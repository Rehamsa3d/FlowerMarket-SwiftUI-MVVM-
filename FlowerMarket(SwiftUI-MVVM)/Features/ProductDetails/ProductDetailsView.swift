//
//  ProductDetailsView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//


import SwiftUI

//
//struct ProductDetailsView: View {
//    
//    //@Binding var showTabBar: Bool
//
//    let product: Product
//    @State private var quantity: Int = 1
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 24) {
//
//                productImage
//                productInfo
//                quantitySelector
//
//                // Extra space so content never hides behind button
//                Color.clear
//                    .frame(height: 20)
//            }
//            .padding()
//        }
//        .safeAreaInset(edge: .bottom) {
//            addToCartButton
//        }
//        .navigationTitle("Details")
//
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar(.hidden, for: .tabBar)
//    }
//}
//
//private extension ProductDetailsView {
//    var productImage: some View {
//        ZStack(alignment: .topLeading) {
//
//            AsyncImage(url: URL(string: product.thumbnail)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxWidth: .infinity)
//            } placeholder: {
//                Color.gray.opacity(0.2)
//                    .frame(height: 280)
//            }
//
//            if let discount = product.discountPercentage {
//                OfferBadge(discount: discount)
//                    .padding()
//            }
//        }
//        .cornerRadius(16)
//    }
//}
//
//private extension ProductDetailsView {
//    var productInfo: some View {
//        VStack(alignment: .leading, spacing: 12) {
//
//            Text(product.title)
//                .font(.title2.bold())
//
//            priceView
//
//            Text(product.description ?? "No description available.")
//                .font(.body)
//                .foregroundColor(.secondary)
//        }
//    }
//}
//
//private extension ProductDetailsView {
//    var quantitySelector: some View {
//        HStack(spacing: 16) {
//
//            Text("Quantity")
//                .font(.headline)
//
//            Spacer()
//
//            Stepper(value: $quantity, in: 1...10) {
//                Text("\(quantity)")
//                    .font(.headline)
//            }
//        }
//    }
//}
//private extension ProductDetailsView {
//    var addToCartButton: some View {
//        Button {
//            addToCart()
//        } label: {
//            Text("Add to Cart")
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .cornerRadius(16)
//        }
//        .padding()
//       // .background(.ultraThinMaterial)
//    }
//}
//
//private extension ProductDetailsView {
//    var priceView: some View {
//        Group {
//            if let discount = product.discountPercentage {
//                HStack(spacing: 8) {
//                    Text("$\(product.price)")
//                        .strikethrough()
//                        .foregroundColor(.secondary)
//
//                    Text(discountedPrice)
//                        .font(.title3.bold())
//                        .foregroundColor(.red)
//                }
//            } else {
//                Text("$\(product.price)")
//                    .font(.title3.bold())
//            }
//        }
//    }
//}
//
import SwiftUI

struct ProductDetailsView: View {
    
    let product: Product
    @State private var quantity: Int = 1
    @Environment(\.dismiss) var dismiss
    // نستخدم EnvironmentObject عشان نوصل لنفس نسخة السلة في كل التطبيق
    @EnvironmentObject var cartManager: CartManager

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
            Button(action: {}) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
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
//private extension ProductDetailsView {
//    var discountedPrice: String {
//        let discounted = product.price * (1 - Double(product.discountPercentage ?? 0) / 100)
//        return String(format: "$%.2f", discounted)
//    }
//
//    func addToCart() {
//        // Hook into ViewModel later
//        print("Added \(quantity) item(s) to cart")
//    }
//}
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
        // الربط الحقيقي مع الـ Manager
        cartManager.addToCart(product: product, quantity: quantity)
        
        // لمسة UI: اهتزاز بسيط (Haptic Feedback) عند الإضافة
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        print("Cart updated: \(cartManager.cartItems.count) items total")
    }
}
