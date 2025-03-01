//
//  RecentLocationsView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI

struct RecentLocationsView: View {
    
    let recentTrips: [Trip] = [
        Trip(destination: "High Meadow Ranch Golf Club", address: "37300 Golf Club Trail, Magnolia, TX 77355", icon: "clock"),
        Trip(destination: "George Bush Intercontinental Airport (IAH)", address: "2800 N Terminal Rd, Houston, TX", icon: "airplane.departure")
    ]
    
    var body: some View {
        
        List(recentTrips) { recentTrip in
            RecentTripView(destination: recentTrip.destination, address: recentTrip.address, icon: recentTrip.icon)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RecentLocationsView()
}
