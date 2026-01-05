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
        VStack(alignment: .leading, spacing: 0) {
            // 1. Image Section
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .overlay(ProgressView())
                }
                .frame(width: 160, height: 160) // حجم أكبر لإبراز الورد
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // زر المفضلة (اختياري)
                Button(action: {}) {
                    Image(systemName: "heart")
                        .font(.system(size: 14, weight: .bold))
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .padding(10)
                }
            }

            // 2. Info Section
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(1)

                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text("$")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.green)
                    
                    Text("\(product.price, specifier: "%.2f")")
                        .font(.system(size: 17, weight: .heavy, design: .rounded))
                        .foregroundColor(.primary)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 4)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(24) // زوايا أنعم
        .shadow(color: Color.black.opacity(0.04), radius: 15, x: 0, y: 8)
        .frame(width: 180) // عرض الكارت بالكامل
    }
}
