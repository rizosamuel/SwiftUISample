//
//  AuthenticationViewModel.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    private let biometricsRepository: BiometricsRepository

    init(biometricsRepo: BiometricsRepository) {
        self.biometricsRepository = biometricsRepo
    }

    func authenticateUser() {
        biometricsRepository.authenticate { [weak self] success, _ in
            DispatchQueue.main.async {
                self?.isAuthenticated = success
            }
        }
    }
}
