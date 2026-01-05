//
//  ShimmerEffect.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 04/01/2026.
//

import SwiftUI


struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: phase),
                            .init(color: .white.opacity(0.5), location: phase + 0.1),
                            .init(color: .clear, location: phase + 0.2)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .scaleEffect(3) // تكبير عشان يغطي المساحة
                    .offset(x: -geo.size.width + (phase * geo.size.width * 2))
                }
            )
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
            .clipped()
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}
