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
    
    func register(name: String, email: String, password: String, phone: String, role: Role) async throws {
        let data: [String: AnyJSON] = ["name": .string(name), "phone": .string(phone), "role_id": .integer(role.rawValue)]
        try await client.auth.signUp(email: email, password: password, data: data)
    }
    
    func login(email: String, password: String) async throws {
        try await client.auth.signIn(email: email, password: password)
    }
    
}
