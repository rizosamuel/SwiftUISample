//
//  NotificationsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct NotificationsView: View {
    
    @EnvironmentObject private var router: RouterImpl
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                
                Text("No new notifications")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                
                Text("Stay in touch! You will find all the new updates here")
                    .font(.callout)
                    .foregroundColor(Color(.systemGray2))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Notifications")
        }
        .accessibilityIdentifier("NotificationsView")
    }
}

#Preview {
    NotificationsView()
}
