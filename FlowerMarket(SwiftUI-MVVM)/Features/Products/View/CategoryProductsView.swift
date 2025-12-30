//
//  CategoryProductsView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI


struct CategoryProductsView: View {
    let title: String
    let products: [Product]

    var body: some View {
        List(products) { product in
            Text(product.title)
        }
        .navigationTitle(title.capitalized)
    }
}
