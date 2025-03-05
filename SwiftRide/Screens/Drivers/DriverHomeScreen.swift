//
//  DriverHomeScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//

import SwiftUI

struct DriverHomeScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @State private var isOnline: Bool = false
    
    private func updateDriverStatus() async {
        
        do {
            let user = try await swiftRideStore.currentUser
            try await swiftRideStore.updateDriverStatus(userId: user.id, isOnline: isOnline, latitude: 10.0, longitude: 20.0)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            Toggle("Online", isOn: $isOnline)
                .fixedSize()
            Spacer()
        }.onChange(of: isOnline) {
            Task {
                // get user location
                await updateDriverStatus()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DriverHomeScreen()
    }.environment(SwiftRideStore(client: .development))
}
