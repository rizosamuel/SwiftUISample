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
                let biometricsRepo = BiometricsRepositoryImpl()
                let userDefaultsRepo = UserDefaultsRepositoryImpl()
                let viewModel = SettingsViewModel(biometricsRepo: biometricsRepo, userDefaultsRepo: userDefaultsRepo)
                SettingsView(viewModel: viewModel)
            case .chat:
                let chatRepo = BonjourChatManager()
                let viewModel = ChatViewModel(chatRepository: chatRepo)
                ChatView(viewModel: viewModel)
            case .featuredProducts:
                let useCase = FeaturedProductsUseCaseImpl()
                let viewModel = FeaturedProductsViewModel(useCase: useCase)
                FeaturedProductsView(viewModel: viewModel)
            case .category(let category):
                let viewModel = CategoryDetailsViewModel(category: category)
                CategoryDetailsView(viewModel: viewModel)
            case .product(let product):
                let viewModel = ProductDetailsViewModel(product: product)
                ProductDetailsView(viewModel: viewModel)
            }
        }
    }
}

extension Data {
    func printJSON() {
        if let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
           let prettyPrintedString = String(data: prettyData, encoding: .utf8) {
            print(prettyPrintedString)
        } else {
            print("Invalid JSON data")
        }
    }
}
