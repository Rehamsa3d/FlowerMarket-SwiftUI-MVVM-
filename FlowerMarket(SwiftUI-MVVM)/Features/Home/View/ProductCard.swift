//
//  ProductCardView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI


struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(12)

            Text(product.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)

            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 120)
        
        .padding()
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
        
//        NavigationLink {
//            ProductDetailsView(product: product)
//        } label: {
//            ProductRow(product: product)
//        }
//        .buttonStyle(.plain)

    }
}
