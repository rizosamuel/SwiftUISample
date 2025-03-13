//
//  DashboardView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject private var router: RouterImpl

    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    @StateObject var viewmodel = HomeViewModel()
  
    
    var body: some View {
        TabView(selection: $router.selectedTabIndex) {
            NavigationStack(path: $router.homePath) {

                HomeView(viewModel: viewmodel)
                    .withNavigationDestinations()
               
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            NavigationStack(path: $router.categoriesPath) {
                CategoriesView()
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            .tag(1)
            
            NavigationStack(path: $router.myOrdersPath) {
                OrdersView()
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("My Orders", systemImage: "shippingbox.fill")
            }
            .tag(2)
            
            NavigationStack(path: $router.accountPath) {
                AccountView()
                    .withNavigationDestinations()
            }
            .tabItem {
                Label("Account", systemImage: "person.fill")
            }
            .tag(3)
        }
    }
}

#Preview {
    DashboardView()
}
