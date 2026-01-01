//
//  CategorySectionView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 30/12/2025.
//

import SwiftUI

struct CategorySectionView: View {
    let category: String
    let products: [Product]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text(category)
                       .font(.title3)
                       .fontWeight(.semibold)


                Spacer()

                NavigationLink("See all") {
                    CategoryProductsView(
                        title: category,
                        products: products
                    )
                }
                .font(.subheadline)
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(products.prefix(5)) { product in
                        ProductCard(product: product)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
