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
    let service: ServiceOption
    let estimatedDistance: Double // in miles
    let estimatedDuration: Double // in minutes
    let arrivalTime: Date
    let description: String
    let imageName: String

    /// Computed property to display time until arrival dynamically
    var timeAway: String {
        let timeInterval = arrivalTime.timeIntervalSinceNow

        if timeInterval <= 0 {
            return "Arriving now"
        } else if timeInterval < 3600 {
            return "\(Int(timeInterval / 60)) min away"
        } else if timeInterval < 86400 {
            return "\(Int(timeInterval / 3600)) hr away"
        } else {
            return "\(Int(timeInterval / 86400)) day away"
        }
    }

    /// Computes the total price dynamically based on the service type
    var price: Double {
        let distanceCost = service.costPerMile * estimatedDistance
        let durationCost = service.costPerMinute * estimatedDuration
        let totalCost = (service.baseFare + distanceCost + durationCost) 
        return totalCost
    }

    /// Retrieves the service name
    var serviceTitle: String {
        service.title
    }

    /// Retrieves the passenger capacity
    var passengerCapacity: Int {
        service.passengers
    }
}



enum ServiceOption: Int, Identifiable, CaseIterable, Codable {
    case comfort = 1
    case uberX = 2
    case uberXL = 3
    case blackSUV = 4

    var id: Self { self }

    var title: String {
        switch self {
            case .comfort: return "Comfort"
            case .uberX: return "Uber X"
            case .uberXL: return "Uber XL"
            case .blackSUV: return "Black SUV"
        }
    }

    var passengers: Int {
        switch self {
            case .comfort, .uberX: return 4
            case .uberXL, .blackSUV: return 6
        }
    }

    var baseFare: Double {
        switch self {
            case .comfort: return 3.50
            case .uberX: return 3.00
            case .uberXL: return 4.50
            case .blackSUV: return 7.00
        }
    }

    var costPerMile: Double {
        switch self {
            case .comfort: return 1.75
            case .uberX: return 1.50
            case .uberXL: return 2.00
            case .blackSUV: return 3.50
        }
    }

    var costPerMinute: Double {
        switch self {
            case .comfort: return 0.30
            case .uberX: return 0.25
            case .uberXL: return 0.40
            case .blackSUV: return 0.60
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
