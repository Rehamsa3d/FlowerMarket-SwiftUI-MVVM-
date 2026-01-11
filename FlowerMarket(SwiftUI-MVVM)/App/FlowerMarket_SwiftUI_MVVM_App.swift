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
    
    @StateObject var cartManager = CartManager() // it will defined as  @EnvironmentObject in all screens we needd it
    @StateObject private var favoritesManager = FavoritesManager()
    
        var body: some Scene {
            WindowGroup {
                AppRootView()
                    .environmentObject(appState)
                    .environmentObject(cartManager) // to be shared allOver the app
                    .environmentObject(favoritesManager)
            }
        }

}
