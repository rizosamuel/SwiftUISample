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
    
    var selectedTab: Int { get set }
    var navigationEventHandler: ((NavigationEvent) -> Void)? { get set }
    
    func navigate(to route: Route, switchTab: Bool)
    func canNavigate(to route: Route) -> Bool
    func goBack()
    func resetToRoot(for tab: Int)
    func resetAll()
    // func presentModal(_ modal: ModalType)
    // func dismissModal()
    // func handleDeepLink(url: URL)
}

class RouterImpl: Router {
    
    @Published var homePath = NavigationPath()
    @Published var categoriesPath = NavigationPath()
    @Published var myOrdersPath = NavigationPath()
    @Published var accountPath = NavigationPath()
    
    @Published var selectedTab: Int = 0
    var navigationEventHandler: ((NavigationEvent) -> Void)?
    
    private var navigationHistory: [Int: [Route]] = [0: [], 1: [], 2: [], 3: []]
    
    func navigate(to route: Route, switchTab: Bool = false) {
        
        guard canNavigate(to: route) else {
            navigationEventHandler?(.navigationFailed(to: route, reason: "Navigation not allowed"))
            return
        }
        
        // Notify that navigation is about to happen
        navigationEventHandler?(.willNavigate(to: route))
        
        // Update selected tab
        selectedTab = switchTab ? route.rawValue : selectedTab
        
        // Add to navigation history for the appropriate tab
        navigationHistory[selectedTab]?.append(route)
        
        // Add to the appropriate navigation path
        switch selectedTab {
        case 0:
            homePath.append(route)
        case 1:
            categoriesPath.append(route)
        case 2:
            myOrdersPath.append(route)
        case 3:
            accountPath.append(route)
        default:
            // This shouldn't happen, but just in case
            homePath.append(route)
        }
        
        // Notify that navigation has happened
        navigationEventHandler?(.didNavigate(to: route))
    }
    
    func canNavigate(to route: Route) -> Bool {
        // check for conditional routing
        return true
    }
    
    func goBack() {
        switch selectedTab {
        case 0 where !homePath.isEmpty:
            homePath.removeLast()
            if var history = navigationHistory[0], !history.isEmpty {
                history.removeLast()
                navigationHistory[0] = history
            }
        case 1 where !categoriesPath.isEmpty:
            categoriesPath.removeLast()
            if var history = navigationHistory[1], !history.isEmpty {
                history.removeLast()
                navigationHistory[1] = history
            }
        case 2 where !myOrdersPath.isEmpty:
            myOrdersPath.removeLast()
            if var history = navigationHistory[2], !history.isEmpty {
                history.removeLast()
                navigationHistory[2] = history
            }
        case 3 where !accountPath.isEmpty:
            accountPath.removeLast()
            if var history = navigationHistory[3], !history.isEmpty {
                history.removeLast()
                navigationHistory[3] = history
            }
        default:
            break
        }
    }
    
    // Reset the navigation stack for a specific tab
    func resetToRoot(for tab: Int) {
        switch tab {
        case 0:
            homePath.removeLast(homePath.count)
            navigationHistory[0] = []
        case 1:
            categoriesPath.removeLast(categoriesPath.count)
            navigationHistory[1] = []
        case 2:
            myOrdersPath.removeLast(myOrdersPath.count)
            navigationHistory[2] = []
        case 3:
            accountPath.removeLast(accountPath.count)
            navigationHistory[3] = []
        default:
            break
        }
    }
    
    func resetAll() {
        homePath.removeLast(homePath.count)
        navigationHistory[0] = []
        categoriesPath.removeLast(categoriesPath.count)
        navigationHistory[1] = []
        myOrdersPath.removeLast(myOrdersPath.count)
        navigationHistory[2] = []
        accountPath.removeLast(accountPath.count)
        navigationHistory[3] = []
        selectedTab = 0
    }
}
