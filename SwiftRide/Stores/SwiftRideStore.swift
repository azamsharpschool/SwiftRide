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
    
    let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
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
