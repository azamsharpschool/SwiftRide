//
//  HomeScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/17/26.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    var body: some View {
        Button("Logout") {
            authenticationController.logout() 
        }
    }
}

#Preview {
    HomeScreen()
}
