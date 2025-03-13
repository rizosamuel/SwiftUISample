//
//  WishlistView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct WishlistView: View {
    
    @EnvironmentObject var router: RouterImpl
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text("No products in your wishlist")
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
        .navigationTitle("Wishlist")
        .accessibilityIdentifier("WishlistView")
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    WishlistView()
}
