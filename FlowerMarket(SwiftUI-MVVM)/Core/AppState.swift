//
//  AppState.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 29/12/2025.
//

import Foundation
internal import Combine

@MainActor
final class AppState: ObservableObject {

    enum Phase {
        case launching
        case home
        case error(String)
    }

    @Published var phase: Phase = .launching

    func bootstrap() async {
        // هنا ممكن تعمل:
        // - check auth
        // - check onboarding
        // - preload tokens
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        phase = .home
    }
}
