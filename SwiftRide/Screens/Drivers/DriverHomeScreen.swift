//
//  DriverHomeScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//

import SwiftUI

struct DriverHomeScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @Environment(LocationManager.self) private var locationManager
    
    @State private var isOnline: Bool = false
    
    private func updateDriverStatus() async {
        
        guard let userLocation = locationManager.userLocation else {
            return
        }
        
        do {
            let user = try await swiftRideStore.currentUser
            try await swiftRideStore.updateDriverStatus(userId: user.id, isOnline: isOnline, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            Toggle("Online", isOn: $isOnline)
                .fixedSize()
            Spacer()
        }
        .task {
            locationManager.requestLocation()
        }
        .onChange(of: isOnline) {
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
    }
    .environment(LocationManager())
    .environment(SwiftRideStore(client: .development))
}
