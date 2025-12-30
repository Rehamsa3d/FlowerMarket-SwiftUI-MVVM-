//
//  ProductCardView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI


struct ProductCardView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 140, height: 140)
            .clipped()
            .cornerRadius(12)

            Text(product.title)
                .font(.subheadline)
                .lineLimit(2)

            Text("$\(product.price, specifier: "%.2f")")
                .font(.footnote.bold())
        }
        .frame(width: 140)
    }
}
