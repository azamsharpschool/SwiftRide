//
//  PreviewData.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/15/25.
//

import Foundation

struct PreviewData {
    
    static let rideEstimates: [RideEstimate] = {
        
        // Creating an array of drivers
        let drivers: [Driver] = [
            Driver(userId: UUID(), licensePlate: "ABC123", make: "Toyota", model: "Camry", rating: 5, isOnline: true, latitude: 37.7749, longitude: -122.4194, distance: 1.2, serviceOption: .uberX),
            Driver(userId: UUID(), licensePlate: "XYZ789", make: "Honda", model: "Civic", rating: 4, isOnline: true, latitude: 40.7128, longitude: -74.0060, distance: 2.5, serviceOption: .uberXL),
            Driver(userId: UUID(), licensePlate: "LMN456", make: "Tesla", model: "Model 3", rating: 5, isOnline: false, latitude: 34.0522, longitude: -118.2437, distance: nil, serviceOption: .blackSUV)
        ]
        
        return drivers.map {
            RideEstimate(userLocation: .apple, destinationLocation: .apple, driver: $0)
        }
    }()

    
}
