//
//  HomeScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/17/26.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(AuthenticationStore.self) private var authenticationStore
    
    var body: some View {
        Button("Logout") {
            authenticationStore.logout()
        }
    }
}

#Preview {
    HomeScreen()
}
