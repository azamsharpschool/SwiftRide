//
//  PreviewData.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/15/25.
//

import Foundation

struct PreviewData {
    
    static let rideOptions: [RideOption] = [
        RideOption(service: .comfort,
                   estimatedDistance: 8.0,
                   estimatedDuration: 15.0,
                   arrivalTime: Date().addingTimeInterval(600),
                   description: "Newer cars with extra legroom",
                   imageName: "car.fill"),

        RideOption(service: .uberX,
                   estimatedDistance: 10.0,
                   estimatedDuration: 20.0,
                   arrivalTime: Date().addingTimeInterval(900),
                   description: "Affordable rides all to yourself",
                   imageName: "car.fill"),

        RideOption(service: .uberXL,
                   estimatedDistance: 12.0,
                   estimatedDuration: 25.0,
                   arrivalTime: Date().addingTimeInterval(1200),
                   description: "Affordable rides for groups up to 6",
                   imageName: "bus.fill"),

        RideOption(service: .blackSUV,
                   estimatedDistance: 15.0,
                   estimatedDuration: 30.0,
                   arrivalTime: Date().addingTimeInterval(1500),
                   description: "Luxury rides for 6 with professional drivers",
                   imageName: "suv.fill")
    ]

    
}
