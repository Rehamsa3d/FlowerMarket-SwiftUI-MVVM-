//
//  FlowerMarket_SwiftUI_MVVM_App.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 29/12/2025.
//

import SwiftUI

@main
struct FlowerMarket_SwiftUI_MVVM_App: App {
    

        
    @StateObject private var appState = AppState()
    
    @StateObject var cartManager = CartManager()
    
        var body: some Scene {
            WindowGroup {
                AppRootView()
                    .environmentObject(appState)
                    .environmentObject(cartManager) // كدا كل الشاشات تقدر تستخدمه
            }
        }

}
