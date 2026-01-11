//
//  FavoritesManager.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 10/01/2026.
//

import Foundation
import Combine


// MARK: - Favorites Manager
class FavoritesManager: ObservableObject {
    
    @Published var favoriteIDs: Set<Int> = []

        
    func toggleFavorite(productID: Int) {
            if favoriteIDs.contains(productID) {
                favoriteIDs.remove(productID)
            } else {
                favoriteIDs.insert(productID)
            }
        }
}

