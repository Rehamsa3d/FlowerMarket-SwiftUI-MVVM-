//
//  SplashView.swift
//  SwiftUI+MVVM
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct SplashView: View {
    let onFinish: () -> Void

    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 12) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .scaleEffect(scale)
                    .opacity(opacity)

                ProgressView()
                    .progressViewStyle(.circular)
        
                    .opacity(opacity)
            }
        }
        .task {
            animate()
            await preload()
            onFinish()
        }
    }

    private func animate() {
        withAnimation(.easeOut(duration: 0.8)) {
            scale = 1
            opacity = 1
        }
    }

    private func preload() async {
        try? await Task.sleep(for: .seconds(1)) // simulate preload
    }
}
