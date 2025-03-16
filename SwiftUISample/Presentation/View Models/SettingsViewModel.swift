//
//  SettingsViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    private let biometricsRepository: BiometricsRepository
    private let userDefaultsRepository: UserDefaultsRepositoryImpl
    
    @Published var isAppLockEnabled: Bool
    
    init(biometricsRepo: BiometricsRepository, userDefaultsRepo: UserDefaultsRepositoryImpl) {
        self.biometricsRepository = biometricsRepo
        self.userDefaultsRepository = userDefaultsRepo
        self.isAppLockEnabled = userDefaultsRepository.get(forKey: Constants.IS_APP_LOCK_KEY, type: Bool.self) ?? false
    }
    
    func toggleAppLock(isEnabled: Bool) {
        
        guard isEnabled else {
            setAppLockEnabled(false)
            isAppLockEnabled = false
            return
        }
        
        biometricsRepository.authenticate { [weak self] success, _ in
            DispatchQueue.main.async {
                if success {
                    self?.isAppLockEnabled = true
                    self?.setAppLockEnabled(true)
                } else {
                    self?.isAppLockEnabled = false
                    self?.setAppLockEnabled(false)
                }
            }
        }
    }
    
    private func setAppLockEnabled(_ isEnabled: Bool) {
        userDefaultsRepository.save(isEnabled, forKey: Constants.IS_APP_LOCK_KEY)
    }
}
