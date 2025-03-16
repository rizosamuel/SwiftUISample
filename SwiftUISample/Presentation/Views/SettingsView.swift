//
//  SettingsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI
import LocalAuthentication

struct SettingsView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Appearance")) {
                        NavigationLink(destination: Text("Mode")) {
                            Text("Mode: Light")
                        }
                    }
                    
                    Section(header: Text("Security")) {
                        Toggle("Enable App Lock", isOn: Binding(
                            get: { viewModel.isAppLockEnabled },
                            set: { viewModel.toggleAppLock(isEnabled: $0) }
                        ))
                    }
                    
                    Section(header: Text("Others")) {
                        Button("Support") {
                            router.navigate(to: .chat)
                        }
                        NavigationLink(destination: Text("Version")) {
                            Text("Version: 1.0.0")
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Settings")
        }
        .accessibilityIdentifier("SettingsView")
    }
}

#Preview {
    let biometricsRepo = BiometricsRepositoryImpl(context: LAContext())
    let userDefaultsRepo = UserDefaultsRepositoryImpl()
    SettingsView(viewModel: SettingsViewModel(biometricsRepo: biometricsRepo, userDefaultsRepo: userDefaultsRepo))
}
