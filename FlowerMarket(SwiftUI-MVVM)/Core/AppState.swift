//
//  AppState.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 29/12/2025.
//

import Foundation
internal import Combine

@MainActor
class AppState: ObservableObject {
    
    enum Phase {
        case loading
        case ready([User])
        case error(String)
    }

    @Published var phase: Phase = .loading

    private let service: UserService

    init(service: UserService = RemoteUserService()) {
        self.service = service
    }

    func bootstrap() async {
        do {
            let users = try await service.fetchUsers()
            phase = .ready(users)
        } catch {
            phase = .error("Failed to load data")
        }
    }
}

