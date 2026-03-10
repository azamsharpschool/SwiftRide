//
//  SwiftRideClientApp.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import SwiftUI

@main
struct SwiftRideClientApp: App {
    
    @AppStorage("roleId") private var roleId: Int = 0
    @State private var authenticationStore = AuthenticationStore(httpClient: HTTPClient())
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch authenticationStore.authenticationState {
                    case .checking:
                        ProgressView()
                    case .authenticated:
                    if roleId == Role.rider.rawValue {
                        RiderRootScreen()
                    } else {
                        DriverHomeScreen()
                    }
                    case .unauthenticated:
                        LoginScreen()
                }
            }.environment(authenticationStore)
                .task {
                   // _ = Keychain<String>.delete("accessToken")
                    print(roleId)
                    authenticationStore.checkAuthentication()
                }
        }
    }
}
