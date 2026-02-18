//
//  SwiftRideClientApp.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import SwiftUI

@main
struct SwiftRideClientApp: App {
    
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                HomeScreen()
            } else {
                LoginScreen() 
            }
        }
    }
}
