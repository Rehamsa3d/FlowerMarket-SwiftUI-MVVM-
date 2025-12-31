//
//  ProductRow.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI

struct ProductRow: View {

    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(product.title)
                .font(.headline)

            Text(product.description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}
