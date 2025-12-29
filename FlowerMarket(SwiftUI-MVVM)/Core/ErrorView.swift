//
//  ErrorView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 29/12/2025.
//


import SwiftUI

struct ErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(message)
                .foregroundColor(.red)

            Button("Retry") {
                retry()
            }
        }
    }
}
