//
//  SplashView.swift
//  SwiftUI+MVVM
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct SplashView: View {

    @EnvironmentObject var appState: AppState
    @State private var scale: CGFloat = 0.6
    @State private var opacity = 0.0

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 16) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .scaleEffect(scale)
                    .opacity(opacity)

                ProgressView()
                    .opacity(opacity)
            }
        }
        .task {
            animate()
            await appState.bootstrap()
        }
    }

    private func animate() {
        withAnimation(.easeOut(duration: 0.8)) {
            scale = 1
            opacity = 1
        }
    }
}
