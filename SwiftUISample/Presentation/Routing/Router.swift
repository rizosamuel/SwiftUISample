//
//  Router.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

// Navigation event types
enum NavigationEvent {
    case willNavigate(to: Route)
    case didNavigate(to: Route)
    case navigationFailed(to: Route, reason: String)
}

protocol Router: ObservableObject {
    var homePath: NavigationPath { get set }
    var categoriesPath: NavigationPath { get set }
    var myOrdersPath: NavigationPath { get set }
    var accountPath: NavigationPath { get set }
    
    // var presentedModal: Modal? { get }
    var presentedModals: [Modal] { get }
    var selectedTabIndex: Int { get set }
    var navigationEventHandler: ((NavigationEvent) -> Void)? { get }
    
    func navigate(to route: Route, switchTab: Bool)
    func canNavigate(to route: Route) -> Bool
    func goBack()
    func resetToRoot(for tab: Tab)
    func resetAll()
    func presentModal(_ modal: Modal)
    func dismissModal()
    // func handleDeepLink(url: URL)
}

class RouterImpl: Router {
    
    @Published var homePath = NavigationPath()
    @Published var categoriesPath = NavigationPath()
    @Published var myOrdersPath = NavigationPath()
    @Published var accountPath = NavigationPath()
    // @Published var presentedModal: Modal? = nil
    @Published var presentedModals: [Modal] = []
    @Published var selectedTabIndex: Int = 0 {
        didSet {
            guard let tab = Tab.getCurrentTab(with: selectedTabIndex) else {
                return
            }
            selectedTab = tab
        }
    }
    
    private(set) var navigationEventHandler: ((NavigationEvent) -> Void)?
    private var navigationHistory: [Tab: [Route]] = [:]
    private var selectedTab: Tab = .home
    
    init() {
        Tab.allCases.forEach { tab in
            navigationHistory[tab] = []
        }
    }
    
    func navigate(to route: Route, switchTab: Bool = false) {
        
        guard canNavigate(to: route) else {
            navigationEventHandler?(.navigationFailed(to: route, reason: "Navigation not allowed"))
            return
        }
        
        // Notify that navigation is about to happen
        navigationEventHandler?(.willNavigate(to: route))
        
        // Update selected tab
        if let targetTab = route.toTab, switchTab {
            selectedTabIndex = targetTab.rawValue
        }
        
        // Add to navigation history for the appropriate tab
        navigationHistory[selectedTab]?.append(route)
        
        // Add to the appropriate navigation path
        if !switchTab {
            switch selectedTab {
            case .home:
                homePath.append(route)
            case .categories:
                categoriesPath.append(route)
            case .myOrders:
                myOrdersPath.append(route)
            case .account:
                accountPath.append(route)
            }
        }
        
        // Notify that navigation has happened
        navigationEventHandler?(.didNavigate(to: route))
    }
    
    func canNavigate(to route: Route) -> Bool {
        // check for conditional routing
        return true
    }
    
    func presentModal(_ modal: Modal) {
        // guard presentedModal != modal else { return }
        // presentedModal = modal
        guard !presentedModals.contains(modal) else { return }
        presentedModals.append(modal)  // Push modal to stack
        
    }
    
    func dismissModal() {
        // presentedModal = nil
        guard !presentedModals.isEmpty else { return }
        presentedModals.removeLast()  // Pop the last modal
    }
    
    func goBack() {
        switch selectedTab {
        case .home where !homePath.isEmpty:
            homePath.removeLast()
        case .categories where !categoriesPath.isEmpty:
            categoriesPath.removeLast()
        case .myOrders where !myOrdersPath.isEmpty:
            myOrdersPath.removeLast()
        case .account where !accountPath.isEmpty:
            accountPath.removeLast()
        default:
            break
        }
        
        if var history = navigationHistory[selectedTab], !history.isEmpty {
            history.removeLast()
            navigationHistory[selectedTab] = history
        }
    }
    
    // Reset the navigation stack for a specific tab
    func resetToRoot(for tab: Tab) {
        navigationHistory[tab] = []
        switch tab {
        case .home:
            homePath.removeLast(homePath.count)
        case .categories:
            categoriesPath.removeLast(categoriesPath.count)
        case .myOrders:
            myOrdersPath.removeLast(myOrdersPath.count)
        case .account:
            accountPath.removeLast(accountPath.count)
        }
    }
    
    func resetAll() {
        homePath.removeLast(homePath.count)
        navigationHistory[.home] = []
        categoriesPath.removeLast(categoriesPath.count)
        navigationHistory[.categories] = []
        myOrdersPath.removeLast(myOrdersPath.count)
        navigationHistory[.myOrders] = []
        accountPath.removeLast(accountPath.count)
        navigationHistory[.account] = []
        selectedTabIndex = 0
        // presentedModal = nil
        presentedModals.removeAll()
    }
    
    var presentedModalBinding: Binding<Modal?> {
        Binding(
            get: {
                // self.presentedModal
                self.presentedModals.last
            },
            set: { newValue in
                // _ in self.dismissModal()
                if newValue == nil {
                    self.dismissModal()
                }
            }
        )
    }
}
