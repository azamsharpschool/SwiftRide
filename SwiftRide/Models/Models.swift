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

struct RideEstimate: Identifiable, Equatable {
    
    let id = UUID()
    
    let userLocation: CLLocation
    let destinationLocation: CLLocation
    
    let driver: Driver
    
    var title: String {
        driver.serviceOption.title
    }
    
    var icon: String {
        driver.serviceOption.icon
    }
    
    var distanceInMiles: Double {
        userLocation.distance(from: destinationLocation) * 0.000621371 // Convert meters to miles
    }
    
    var description: String {
        driver.serviceOption.description
    }
    
    var serviceOption: ServiceOption {
        driver.serviceOption
    }
    
    var passengerCapacity: Int {
        driver.serviceOption.passengers
    }
    
    /// Estimated duration in **minutes**, assuming an average speed of 25 mph
    var estimatedDuration: Double {
        let averageSpeedMph = 25.0 // Assume an average city driving speed
        return (distanceInMiles / averageSpeedMph) * 60.0
    }
    
    var estimatedFare: Double {
        let service = driver.serviceOption
        let fare = service.baseFare + (service.costPerMile * distanceInMiles) + (service.costPerMinute * estimatedDuration)
        return max(fare, service.minimumFare) // Ensure the fare is at least the minimum fare
    }
    
    static func == (lhs: RideEstimate, rhs: RideEstimate) -> Bool {
        return lhs.id == rhs.id
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
    
    var description: String {
        switch self {
        case .comfort: return "A more spacious and comfortable ride with better vehicles."
        case .uberX: return "Affordable everyday rides with standard cars."
        case .uberXL: return "Larger vehicles for up to 6 passengers."
        case .blackSUV: return "Luxury SUVs for premium rides and larger groups."
        }
    }
    
    var icon: String {
        switch self {
        case .comfort: return "car.fill"         // SF Symbol for a generic car
        case .uberX: return "car.fill"               // Another SF Symbol variant
        case .uberXL: return "car.fill"         // Resembles a larger vehicle
        case .blackSUV: return "suv.side.fill"
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
    
    var minimumFare: Double {
        switch self {
        case .comfort: return 12.00
        case .uberX: return 10.00
        case .uberXL: return 15.00
        case .blackSUV: return 25.00
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
