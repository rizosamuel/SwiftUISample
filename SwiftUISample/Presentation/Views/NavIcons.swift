//
//  NavIcons.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

struct NavIcons: View {
    
    @EnvironmentObject var router: RouterImpl
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { router.navigate(to: .wishlist) }) {
                Image(systemName: "heart")
            }
            .accessibilityIdentifier("Wishlist")
            Button(action: { router.navigate(to: .notifications) }) {
                Image(systemName: "bell")
            }
            .accessibilityIdentifier("Notifications")
            Button(action: { router.navigate(to: .cart) }) {
                Image(systemName: "cart")
            }
            .accessibilityIdentifier("Cart")
        }
    }
}
