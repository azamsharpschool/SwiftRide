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
    let accessToken: String?
    let refreshToken: String?
    let userId: Int?
    let roleId: Int?
    let isOnline: Bool?
}

struct RefreshTokenRequest: Codable {
    let refreshToken: String
}

struct RefreshTokenResponse: Codable {
    let accessToken: String
}

struct SecureResponse: Codable {
    let success: Bool
    let message: String?
}

struct APIResponse: Codable {
    let success: Bool
    let message: String?
}

enum ServiceType: String, Codable, CaseIterable {
    
    case swiftrideX = "SWIFTRIDE_X"
    case swiftrideBlack = "SWIFTRIDE_BLACK"
    case swiftrideSUV = "SWIFTRIDE_SUV"
    
    var displayName: String {
        switch self {
        case .swiftrideX:
            return "SwiftRide X"
        case .swiftrideBlack:
            return "SwiftRide Black"
        case .swiftrideSUV:
            return "SwiftRide SUV"
        }
    }
}

struct CreateRideRequest: Codable {
    
    var serviceType: ServiceType = .swiftrideX
    
    var pickupLatitude: Double = 0
    var pickupLongitude: Double = 0
    var pickupAddress: String = ""
    
    var destinationLatitude: Double = 0
    var destinationLongitude: Double = 0
    var destinationAddress: String = ""
}
