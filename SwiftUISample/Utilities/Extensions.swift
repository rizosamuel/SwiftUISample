//
//  Extensions.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI
import LocalAuthentication

// MARK: - Navigation Destination Extension
extension View {
    func withNavigationDestinations() -> some View {
        self.navigationDestination(for: Route.self) { route in
            switch route {
            case .home, .categories, .myOrders, .account:
                EmptyView()
            case .cart:
                CartView()
            case .wishlist:
                WishlistView()
            case .notifications:
                NotificationsView()
            case .settings:
                let biometricsRepo = BiometricsRepositoryImpl(context: LAContext())
                let userDefaultsRepo = UserDefaultsRepositoryImpl()
                let viewModel = SettingsViewModel(biometricsRepo: biometricsRepo, userDefaultsRepo: userDefaultsRepo)
                SettingsView(viewModel: viewModel)
            case .chat:
                let chatRepo = MultipeerManager()
                let viewModel = ChatViewModel(chatRepository: chatRepo)
                ChatView(viewModel: viewModel)
            case .featuredProducts:
                let viewModel = FeaturedProductsViewModel()
                FeaturedProductsView(viewModel: viewModel)
            }
        }
    }
}
