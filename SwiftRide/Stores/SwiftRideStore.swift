//
//  SwiftRideStore.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/3/25.
//

import Foundation
import Observation
import Supabase
import MapKit

protocol SwiftRideStoreProtocol {
    
}


@Observable
class SwiftRideStore: SwiftRideStoreProtocol {
    
    private var client: SupabaseClient
    var rideEstimates: [RideEstimate] = []
    
    //var nearbyDrivers: [Driver] = []
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    var currentUser: User {
        get async throws {
            return try await client.auth.user()
        }
    }
    
    var nearbyDrivers: [Driver] {
        rideEstimates.map { $0.driver }
    }
    
    func register(userRegistration: UserRegistration) async throws {
        
        let data: [String: AnyJSON] = ["name": .string(userRegistration.fullName), "phone": .string(userRegistration.phoneNumber), "role_id": .integer(userRegistration.selectedRole.rawValue)]
                                       
        let response = try await client.auth.signUp(email: userRegistration.email, password: userRegistration.password, data: data)
        
        if response.session != nil, userRegistration.selectedRole == .driver {
            
            let driverData: [String: AnyJSON] = ["user_id": .string(response.user.id.uuidString), "license_plate": .string(userRegistration.licensePlate), "make": .string(userRegistration.make), "model": .string(userRegistration.model), "service_option_id": .integer(userRegistration.serviceOption.rawValue)]
            
            try await client
                .from("drivers")
                .insert(driverData)
                .execute()
        }
    }
   
    func login(email: String, password: String) async throws {
        try await client.auth.signIn(email: email, password: password)
    }
    
    func signout() async throws {
        try await client.auth.signOut()
    }
    
    func updateDriverStatus(userId: UUID, isOnline: Bool, latitude: Double, longitude: Double) async throws {
        
        let data: [String: AnyJSON] = ["is_online": .bool(isOnline), "location": .string("POINT(\(longitude) \(latitude))")]
        
        try await client
            .from("drivers")
            .update(data)
            .eq("user_id", value: userId)
            .execute()
    }
    
    func loadRideEstimates(coordinate: CLLocationCoordinate2D) async throws {
        
        let nearbyDrivers: [Driver] = try await client
            .rpc("nearby_drivers", params: ["lat": coordinate.latitude, "long": coordinate.longitude])
            .execute()
            .value
        
        rideEstimates = nearbyDrivers.map { RideEstimate(driver: $0) }
        
        //return nearbyDrivers.map { RideEstimate(driver: $0) }
    }
    /*
    func startListeningForNearbyDrivers() async throws {
        // Create channel
        let channel = client.realtimeV2.channel("nearby-drivers")
        let updates = channel.postgresChange(UpdateAction.self, schema: "public", table: "driver_statuses")
        
        await channel.subscribe()
        
        for await update in updates {
            let driverStatus = try update.decodeRecord(as: DriverStatus.self, decoder: JSONDecoder())
            // if driver is offline then remove from nearby drivers else append
            if driverStatus.isOnline {
                // find the driver and update the coordinate property
                guard let index = nearbyDrivers.firstIndex(where: { $0.userId == driverStatus.userId }) else {
                    self.nearbyDrivers.append(driver)
                    return
                }
                
                // if exists then update the driver 
                nearbyDrivers[index].latitude = driver.latitude
                nearbyDrivers[index].longitude = driver.longitude
                
            } else {
                // If driver is offline, remove from the array
                self.nearbyDrivers.removeAll { $0.userId == driver.userId }
            }
        }
    } */
    
    func stopListeningForNearbyDrivers() {
        
    }
}
