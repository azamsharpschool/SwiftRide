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
    @AppStorage("roleId") private var roleId: Int = 0
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                if roleId == Role.rider.rawValue {
                    RiderHomeScreen()
                } else {
                    DriverHomeScreen() 
                }
            } else {
                LoginScreen()
            }
        }
    }
}
