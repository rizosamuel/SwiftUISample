//
//  AuthenticationView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 16/03/25.
//

import SwiftUI

struct AuthenticationView: View {
    
    @StateObject private var viewModel: AuthenticationViewModel
    
    init(viewModel: AuthenticationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "lock.shield")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                
                Text("Biometric Authentication Required")
                    .font(.headline)
                    .padding()
                
                Button(action: {
                    viewModel.authenticateUser()
                }) {
                    Text("Authenticate")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 12)
                
                Spacer()
            }
            .onAppear {
                viewModel.authenticateUser()
            }
            .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
                DashboardView()
            }
        }
        .accessibilityIdentifier("AuthenticationView")
    }
}

#Preview {
    let biometricsRepo = BiometricsRepositoryImpl()
    let viewModel = AuthenticationViewModel(biometricsRepo: biometricsRepo)
    AuthenticationView(viewModel: viewModel)
}
