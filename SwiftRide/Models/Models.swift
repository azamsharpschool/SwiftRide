//
//  Models.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/2/25.
//

import Foundation
import MapKit 

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let subTitle: String
    
    var address: String {
        "\(name) \(subTitle)"
    }
}

struct Trip: Identifiable, Equatable {
    let id = UUID()
    var pickup: String = ""
    var destination: String = ""
}


enum Role: Int, Identifiable, CaseIterable {
    
    case rider = 1
    case driver = 2
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .rider:
                return "Rider"
            case .driver:
                return "Driver"
        }
    }
}

struct RideOption: Identifiable {
    let id = UUID()
    let name: String
    let passengers: Int
    let price: String
    let discountedPrice: String?
    let arrivalTime: String
    let timeAway: String
    let description: String
    let imageName: String
    let isSelected: Bool
}

enum ServiceOption: Int, Identifiable, CaseIterable, Codable {
    case comfort = 1
    case uberX = 2
    case uberXL = 3
    case blackSUV = 4
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .comfort:
                return "Comfort"
            case .uberX:
                return "Uber X"
            case .uberXL:
                return "Uber XL"
            case .blackSUV:
                return "Black SUV"
        }
    }
}

struct Driver: Codable, Identifiable {
    let userId: UUID
    let licensePlate: String
    let make: String
    let model: String
    var rating: Int?
    var isOnline: Bool = false
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var distance: Double?
    var serviceOption: ServiceOption = .uberX
    
    var id: UUID {
        userId
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case licensePlate = "license_plate"
        case make, model, rating
        case isOnline = "is_online"
        case latitude = "lat"
        case longitude = "long"
        case distance = "dist_meters"
        case serviceOption = "service_option_id"
    }
}
