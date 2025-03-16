//
//  DriverHomeScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//

import SwiftUI
import MapKit

struct DriverHomeScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @Environment(LocationManager.self) private var locationManager
    @State private var timer: Timer? = nil
    
    @State private var isOnline: Bool = false
    
    func generateRandomCoordinatesNearApplePark() -> CLLocationCoordinate2D {
        // Apple Park coordinates
        let appleParkLatitude = 37.3346
        let appleParkLongitude = -122.0090
        
        // Define the range for random offsets (in degrees)
        let latitudeOffsetRange = 0.01 // Approximately 1.1 km
        let longitudeOffsetRange = 0.01 // Approximately 1.1 km
        
        // Generate random offsets
        let randomLatitudeOffset = Double.random(in: -latitudeOffsetRange...latitudeOffsetRange)
        let randomLongitudeOffset = Double.random(in: -longitudeOffsetRange...longitudeOffsetRange)
        
        // Calculate new coordinates
        let randomLatitude = appleParkLatitude + randomLatitudeOffset
        let randomLongitude = appleParkLongitude + randomLongitudeOffset
        
        return CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
    }
    
    private func updateDriverStatus() async {
        
        guard let userLocation = locationManager.userLocation else {
            return
        }
        
        do {
            let user = try await swiftRideStore.currentUser
            let coordinate = generateRandomCoordinatesNearApplePark()
            //let coordinate = userLocation.coordinate
            try await swiftRideStore.updateDriverStatus(userId: user.id, isOnline: isOnline, latitude: coordinate.latitude, longitude: coordinate.longitude)
            
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
                await updateDriverStatus()
            }
            
            /*
            if isOnline {
                // Start the timer when the driver goes online
                timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                    print("timer fired")
                    Task {
                        await updateDriverStatus()
                    }
                }
            } else {
                // Stop the timer when the driver goes offline
                timer?.invalidate()
                timer = nil
                
                // Update the driver status one last time
                Task {
                    await updateDriverStatus()
                }
            } */
            
            
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
