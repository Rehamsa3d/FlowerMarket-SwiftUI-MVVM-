//
//  ProductsView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI

struct ProductsView: View {

    let products: [Products]

    var body: some View {
        NavigationStack {
            List(products) { product in
                HStack {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text("\(product.title)").fontWeight(.bold)
                        Text("\(product.description)")
                            .lineLimit(2)
                        Text("price: \(product.price)")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Products")
        }
    }
}

