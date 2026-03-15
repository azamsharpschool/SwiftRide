//
//  DriverSettingScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/14/26.
//

import SwiftUI

struct DriverSettingScreen: View {
    
    @AppStorage("isOnline") private var isOnline: Bool = true
    @Environment(AuthenticationStore.self) private var authenticatedStore
    @Environment(SwiftRideStore.self) private var swiftRideStore
    
    var body: some View {
        VStack {
            Toggle(isOn: $isOnline) {
                Text("Is Online")
            }.fixedSize()
            
            Button("Sign out") {
                authenticatedStore.logout()
            }
        }.onChange(of: isOnline, initial: false) {
            // make the isOnline true/false
            Task {
                try await swiftRideStore.updateDriverStatus(isOnline: isOnline)
            }
        }
    }
}

#Preview {
    DriverSettingScreen()
        .environment(AuthenticationStore(httpClient: .development))
        .environment(SwiftRideStore(httpClient: .development))
}
