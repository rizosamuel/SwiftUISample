//
//  CartView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var router: RouterImpl
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "cart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text("No products in your cart")
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
        .navigationTitle("Cart")
        .accessibilityIdentifier("CartView")
    }
}

#Preview {
    CartView()
}
