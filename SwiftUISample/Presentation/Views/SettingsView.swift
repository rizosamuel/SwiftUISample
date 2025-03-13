//
//  SettingsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Appearance")) {
                        NavigationLink(destination: Text("Mode")) {
                            Text("Mode: Light")
                        }
                    }
                    Section(header: Text("About")) {
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
    }
}

#Preview {
    SettingsView()
}
