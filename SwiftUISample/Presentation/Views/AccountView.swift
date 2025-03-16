//
//  AccountView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var router: RouterImpl
    @StateObject private var viewModel: AccountViewModel
    
    init(viewModel: AccountViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack(spacing: 30) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    Text("User")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding()
                
                List {
                    Section(header: Text("My Activity")) {
                        Button("Wishlist") { router.navigate(to: .wishlist) }
                    }
                    
                    Section(header: Text("Others")) {
                        Button("Settings") { router.navigate(to: .settings) }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Account")
        }
        .accessibilityIdentifier("AccountView")
    }
}

#Preview {
    AccountView(viewModel: AccountViewModel())
}
