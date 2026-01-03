//
//  ProductDetailsView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//


import SwiftUI


struct ProductDetailsView: View {
    
    //@Binding var showTabBar: Bool

    let product: Product
    @State private var quantity: Int = 1

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                productImage
                productInfo
                quantitySelector

                // Extra space so content never hides behind button
                Color.clear
                    .frame(height: 20)
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            addToCartButton
        }
        .navigationTitle("Details")

        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

private extension ProductDetailsView {
    var productImage: some View {
        ZStack(alignment: .topLeading) {

            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Color.gray.opacity(0.2)
                    .frame(height: 280)
            }

            if let discount = product.discountPercentage {
                OfferBadge(discount: discount)
                    .padding()
            }
        }
        .cornerRadius(16)
    }
}

private extension ProductDetailsView {
    var productInfo: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(product.title)
                .font(.title2.bold())

            priceView

            Text(product.description ?? "No description available.")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

private extension ProductDetailsView {
    var quantitySelector: some View {
        HStack(spacing: 16) {

            Text("Quantity")
                .font(.headline)

            Spacer()

            Stepper(value: $quantity, in: 1...10) {
                Text("\(quantity)")
                    .font(.headline)
            }
        }
    }
}
private extension ProductDetailsView {
    var addToCartButton: some View {
        Button {
            addToCart()
        } label: {
            Text("Add to Cart")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(16)
        }
        .padding()
       // .background(.ultraThinMaterial)
    }
}

private extension ProductDetailsView {
    var priceView: some View {
        Group {
            if let discount = product.discountPercentage {
                HStack(spacing: 8) {
                    Text("$\(product.price)")
                        .strikethrough()
                        .foregroundColor(.secondary)

                    Text(discountedPrice)
                        .font(.title3.bold())
                        .foregroundColor(.red)
                }
            } else {
                Text("$\(product.price)")
                    .font(.title3.bold())
            }
        }
    }
}

private extension ProductDetailsView {
    var discountedPrice: String {
        let discounted = product.price * (1 - Double(product.discountPercentage ?? 0) / 100)
        return String(format: "$%.2f", discounted)
    }

    func addToCart() {
        // Hook into ViewModel later
        print("Added \(quantity) item(s) to cart")
    }
}
