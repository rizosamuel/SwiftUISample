//
//  Extensions.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

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
                SettingsView()
            case .chat: 
                ChatView(viewModel: ChatViewModel(chatRepository: MultipeerManager()))
            case .featuredProducts:
                FeaturedProductsView(viewModel: FeaturedProductsViewModel())
            }
        }
    }
}
