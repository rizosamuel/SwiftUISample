//
//  NotificationsView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct NotificationsView: View {
    
    @EnvironmentObject var router: RouterImpl
    
    var body: some View {
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
            
            Button(action: {
                router.resetAll()
            }) {
                Text("View Products")
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
        .navigationTitle("Notifications")
    }
}

#Preview {
    NotificationsView()
}
