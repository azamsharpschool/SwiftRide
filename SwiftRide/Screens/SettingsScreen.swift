//
//  SettingsScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    
    private func signout() async {
        do {
            try await swiftRideStore.signout()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Button("Signout") {
            Task { await signout() }
        }
    }
}

#Preview {
    SettingsScreen()
        .environment(SwiftRideStore(client: .development))
}
