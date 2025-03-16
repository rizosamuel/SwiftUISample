//
//  Route.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

enum Tab: Int, CaseIterable {
    case home
    case categories
    case myOrders
    case account
    
    static func getCurrentTab(with index:Int) -> Tab? {
        return Tab.allCases.first(where: {$0.rawValue == index})
    }
}

enum Route: Hashable {
    
    case home
    case categories
    case myOrders
    case account
    case cart
    case wishlist
    case notifications
    case settings
    case chat
    case featuredProducts
    case category(Category)
    case product(Product)
    
    var toTab: Tab? {
        switch self {
        case .home:
            return Tab.home
        case .categories:
            return Tab.categories
        case .myOrders:
            return Tab.myOrders
        case .account:
            return Tab.account
        default:
            return nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine("home")
        case .categories:
            hasher.combine("categories")
        case .myOrders:
            hasher.combine("my orders")
        case .account:
            hasher.combine("account")
        case .cart:
            hasher.combine("cart")
        case .wishlist:
            hasher.combine("wishlist")
        case .notifications:
            hasher.combine("notifications")
        case .settings:
            hasher.combine("settings")
        case .chat:
            hasher.combine("chat")
        case .featuredProducts:
            hasher.combine("featured products")
        case .category(let category):
            hasher.combine(category.id)
        case .product(let product):
            hasher.combine(product.id)
        }
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home),
            (.categories, .categories),
            (.myOrders, .myOrders),
            (.account, .account),
            (.cart, .cart),
            (.wishlist, .wishlist),
            (.notifications, .notifications),
            (.settings, .settings),
            (.chat, .chat),
            (.featuredProducts, .featuredProducts):
            return true
        case (.category(let lhs), .category(let rhs)):
            return lhs.id == rhs.id
        case (.product(let lhs), .product(let rhs)):
            return lhs.id == rhs.id
        default:
            return false
        }
    }
}
