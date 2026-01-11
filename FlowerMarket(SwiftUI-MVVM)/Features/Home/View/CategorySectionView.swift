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
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favorites: FavoritesManager
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
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

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products.prefix(5)) { product in
                        
                        NavigationLink {
                            ProductDetailsView(product: product, isFavorite: favorites.favoriteIDs.contains(product.id))
                        }
                        label: {
                            ProductCard(
                                product: product,
                                onFavorite: {
                                    favorites.toggleFavorite(productID: product.id)
                                },
                                onAddToCart: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                           // cart.add(product: product)
                                        }
                                    cartManager.addToCart(product: product)

                                }, isFavorite: favorites.favoriteIDs.contains(product.id)
                            )


                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(products.prefix(5)) { product in
//                        
//                        NavigationLink {
//                            ProductDetailsView(product: product, isFavorite: favorites.favoriteIDs.contains(product.id))
//                        }
//                        label: {
//                            ProductCard(
//                                product: product,
//                                onFavorite: {
//                                    favorites.toggleFavorite(productID: product.id)
//                                },
//                                onAddToCart: {
//                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
//                                          ////  cart.add(product: product)
//                                        }
//                                   // cartManager.addToCart(product: product, quantity: quantity)
//
//                                }, isFavorite: favorites.favoriteIDs.contains(product.id)
//                            )
//
//
//                        }
//                        .buttonStyle(.plain)
//                    }
//                }
//                .padding(.horizontal)
//            }
        }
    }
}

extension CategorySectionView {
    
}
