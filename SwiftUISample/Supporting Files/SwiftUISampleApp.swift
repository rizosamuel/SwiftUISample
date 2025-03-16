//
//  SwiftUISampleApp.swift
//  SwiftUISample
//
//  Created by Rijo Samuel on 11/03/25.
//

import SwiftUI

@main
struct SwiftUISampleApp: App {
    
    @StateObject private var router = RouterImpl()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(router)
        }
    }
}
