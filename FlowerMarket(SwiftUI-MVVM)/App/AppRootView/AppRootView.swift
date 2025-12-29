//
//  AppRootView.swift
//  SwiftUI+MVVM
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct AppRootView: View {
    
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch appState.phase {
        case .loading:
            SplashView()

        case .ready(let users):
            UsersView(users: users)

        case .error(let message):
            ErrorView(message: message) {
                Task {
                    await appState.bootstrap()
                }
            }
        }
    }
}

