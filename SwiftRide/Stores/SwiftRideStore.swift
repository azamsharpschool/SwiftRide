//
//  SwiftRideStore.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/3/25.
//

import Foundation
import Observation
import Supabase

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
    
    func register(name: String, email: String, password: String, phone: String, role: Role, serviceOption: ServiceOption? = nil) async throws {
        
        let data: [String: AnyJSON] = ["name": .string(name), "phone": .string(phone), "role_id": .integer(role.rawValue), "service_option_id": serviceOption != nil ? .integer(serviceOption!.rawValue) : nil]
        
        try await client.auth.signUp(email: email, password: password, data: data)
    }
    
    func login(email: String, password: String) async throws {
        try await client.auth.signIn(email: email, password: password)
    }
    
    func signout() async throws {
        try await client.auth.signOut()
    }
    
    func updateDriverStatus(userId: UUID, isOnline: Bool, latitude: Double, longitude: Double) async throws {
        
        let data: [String: AnyJSON] = ["user_id": .string(userId.uuidString), "is_online": .bool(isOnline), "latitude": .double(latitude), "longitude": .double(longitude)]
        
        try await client.from("driver_statuses")
            .upsert(data, onConflict: "user_id")
            .execute()
    }
    
    func loadNearbyDrivers() async throws {
        // load only drivers that are online
        nearbyDrivers = try await client
            .from("driver_statuses")
            .select()
            .eq("is_online", value: true)
            .execute()
            .value
    }
    
    func startListeningForNearbyDrivers() async throws {
        // Create channel
        let channel = client.realtimeV2.channel("nearby-drivers")
        let updates = channel.postgresChange(UpdateAction.self, schema: "public", table: "driver_statuses")
        
        await channel.subscribe()
        
        for await update in updates {
            let driver = try update.decodeRecord(as: Driver.self, decoder: JSONDecoder())
            // if driver is offline then remove from nearby drivers else append
            if driver.isOnline {
                // find the driver and update the coordinate property
                guard let index = nearbyDrivers.firstIndex(where: { $0.userId == driver.userId }) else {
                    self.nearbyDrivers.append(driver)
                    return
                }
                
                // if exists then update the driver 
                nearbyDrivers[index].latitude = driver.coordinate.latitude
                nearbyDrivers[index].longitude = driver.coordinate.longitude
                
            } else {
                // If driver is offline, remove from the array
                self.nearbyDrivers.removeAll { $0.userId == driver.userId }
            }
        }
    }
    
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
