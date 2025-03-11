//
//  OrdersView.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject var router: RouterImpl
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search orders...", text: $searchText)
                        .padding(10)
                        .cornerRadius(8)
                    
                    Button(action: {
                        // Filter action
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .padding()
                            .cornerRadius(8)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray), lineWidth: 1) // Properly rounded border
                )
                .padding()
                
                Spacer()
                
                VStack {
                    Image(systemName: "shippingbox.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    
                    Text("You haven't placed any orders")
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
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("My Orders")
            .toolbar {
                // Navigation Bar buttons
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavIcons()
                }
            }
        }
    }
}

#Preview {
    OrdersView()
}

