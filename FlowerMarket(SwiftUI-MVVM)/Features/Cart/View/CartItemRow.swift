//
//  CartItemRow.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 04/01/2026.
//

import SwiftUI


struct CartItemRow: View {
    var item: CartItem
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: item.product.thumbnail)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.product.title)
                    .font(.headline)
                
                Text("$\(item.price, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 10) {
                Button { cartManager.updateQuantity(for: item, delta: -1) } label: {
                    Image(systemName: "minus.square").foregroundColor(.secondary)
                }
                
                Text("\(item.quantity)")
                    .fontWeight(.bold)
                
                Button { cartManager.updateQuantity(for: item, delta: 1) } label: {
                    Image(systemName: "plus.square.fill").foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.03), radius: 5, y: 2)
    }
}
