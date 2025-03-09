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



@Observable
class SwiftRideStore {
    
    private var client: SupabaseClient
    var nearbyDrivers: [Driver] = []
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    var currentUser: User {
        get async throws {
            return try await client.auth.user()
        }
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
    
    func loadNearbyDriversBy(coordinate: CLLocationCoordinate2D) async throws {
        
        nearbyDrivers = try await client
            .rpc("nearby_drivers", params: ["lat": coordinate.latitude, "long": coordinate.longitude])
            .execute()
            .value
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
    
    // options are based on what is around you...
    func getRideOptions() -> [RideOption] {
        [
           RideOption(name: "Comfort", passengers: 4, price: "$32.06", discountedPrice: nil, arrivalTime: "11:57 PM", timeAway: "11 min away", description: "Newer cars with extra legroom", imageName: "car.fill", isSelected: true),
           RideOption(name: "UberX", passengers: 4, price: "$31.28", discountedPrice: "$25.93", arrivalTime: "11:56 PM", timeAway: "12 min away", description: "Affordable rides all to yourself", imageName: "car.fill", isSelected: false),
           RideOption(name: "UberXL", passengers: 6, price: "$40.37", discountedPrice: nil, arrivalTime: "11:47 PM", timeAway: "6 min away", description: "Affordable rides for groups up to 6", imageName: "bus.fill", isSelected: false),
           RideOption(name: "Black SUV", passengers: 6, price: "$77.86", discountedPrice: nil, arrivalTime: "11:51 PM", timeAway: "7 min away", description: "Luxury rides for 6 with professional drivers", imageName: "suv.fill", isSelected: false)
       ]
    }
}
