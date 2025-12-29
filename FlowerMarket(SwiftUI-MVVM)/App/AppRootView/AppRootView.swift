//
//  AppRootView.swift
//  SwiftUI+MVVM
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct AppRootView: View {
    @State private var isReady = false

    var body: some View {
        if isReady {
            UsersView()
        } else {
            SplashView {
                isReady = true
            }
        }
    }
}
