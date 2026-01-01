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
        HStack(alignment: .center, spacing: 0){
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(12)
            
            
            VStack(alignment: .leading, spacing: 0) {
               
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.footnote.bold())
            }
//            .frame(width: 140)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    
        .contentShape(Rectangle())
        .onTapGesture {
            // open product
        }
        .buttonStyle(.plain)

    }

}
