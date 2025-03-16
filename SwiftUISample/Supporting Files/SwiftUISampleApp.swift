//
//  SwiftUISampleApp.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI
import LocalAuthentication

@main
struct SwiftUISampleApp: App {
    
    private let router = RouterImpl()
    private let userDefaultsRepository = UserDefaultsRepositoryImpl()
    
    var isAppLockEnabled: Bool {
        userDefaultsRepository.get(forKey: Constants.IS_APP_LOCK_KEY, type: Bool.self) ?? false
    }
    
    var body: some Scene {
        WindowGroup {
            if isAppLockEnabled {
                let biometricsRepo = BiometricsRepositoryImpl(context: LAContext())
                let viewModel = AuthenticationViewModel(biometricsRepo: biometricsRepo)
                AuthenticationView(viewModel: viewModel)
                    .environmentObject(router)
            } else {
                DashboardView()
                    .environmentObject(router)
            }
        }
    }
}
