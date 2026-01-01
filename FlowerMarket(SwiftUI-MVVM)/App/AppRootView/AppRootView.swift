//
//  AppRootView.swift
//  SwiftUI+MVVM
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct AppRootView: View {

    @StateObject private var appState = AppState()

    var body: some View {
        switch appState.phase {
        case .launching:
            SplashView()
                .task {
                    await appState.bootstrap()
                }

        case .home:
            RootView()
        case .error(let message):
            Text(message)
        }
    }
}
