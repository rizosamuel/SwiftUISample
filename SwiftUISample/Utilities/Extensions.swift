//
//  Extensions.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

extension View {
    // Navigation Destination Extension
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
    
    // Modal Destination Extension
    func withModals(router: RouterImpl) -> some View {
        self.sheet(item: router.presentedModalBinding) { modal in
            switch modal {
            case .addProduct:
                let useCase = FeaturedProductsUseCaseImpl()
                let viewModel = AddProductViewModel(useCase: useCase)
                AddProductView(viewModel: viewModel)
            case .cart:
                CartView()
            }
        }
    }
}

extension Data {
    func prettyPrinted() -> String {
        if let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
           let prettyPrintedString = String(data: prettyData, encoding: .utf8) {
            return prettyPrintedString
        } else {
            return "Could not pretty print Invalid JSON data"
        }
    }
}

extension String {
    var localized: String {
        return String(localized: String.LocalizationValue(self))
    }
}
