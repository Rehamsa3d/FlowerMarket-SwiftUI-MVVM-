//
//  OfferBadge.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//

import SwiftUI


struct OfferBadge: View {

    let discount: Float

    var body: some View {
        Text("-\(discount)%")
            .font(.caption.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.red)
            .clipShape(Capsule())
    }
}
