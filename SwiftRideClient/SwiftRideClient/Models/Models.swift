//
//  DTOs.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import Foundation

enum Role: Int, CaseIterable, Identifiable, Codable {
    case rider = 1
    case driver = 2

    var id: Int {
        rawValue
    }
    
    var title: String {
        switch self {
            case .rider:
                return "Rider"
            case .driver:
                return "Driver"
        }
    }
}

struct RegisterRequest: Codable {
    let username: String
    let password: String
    let roleId: Int
    var make: String?
    var model: String?
    var licensePlate: String?
}

struct RegisterResponse: Codable {
    let message: String?
    let success: Bool
}

struct LoginResponse: Codable {
    let message: String?
    let success: Bool
    let token: String?
    let userId: Int?
    let roleId: Int?
}
