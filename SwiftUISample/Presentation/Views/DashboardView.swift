//
//  DashboardView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var categoriesViewModel = CategoriesViewModel()
    @StateObject private var ordersViewModel = MyOrdersViewModel()
    @StateObject private var accountViewModel = AccountViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        TabView(selection: $router.selectedTabIndex) {
            
            // home tab
            NavigationStack(path: $router.homePath) {
                HomeView(viewModel: homeViewModel)
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // categories tab
            NavigationStack(path: $router.categoriesPath) {
                CategoriesView(viewModel: categoriesViewModel)
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            .tag(1)
            
            // my orders tab
            NavigationStack(path: $router.myOrdersPath) {
                OrdersView(viewModel: ordersViewModel)
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("My Orders", systemImage: "shippingbox.fill")
            }
            .tag(2)
            
            // account tab
            NavigationStack(path: $router.accountPath) {
                AccountView(viewModel: accountViewModel)
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("Account", systemImage: "person.fill")
            }
            .tag(3)
        }
        .withModals(router: router)
    }
}

#Preview {
    DashboardView()
}
