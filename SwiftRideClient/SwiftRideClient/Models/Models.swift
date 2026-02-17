//
//  DTOs.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import Foundation

enum Role: CaseIterable, Identifiable {
    case rider
    case driver

    var id: Int {
        switch self {
            case .rider:
                return 1
            case .driver:
                return 2
        }
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
