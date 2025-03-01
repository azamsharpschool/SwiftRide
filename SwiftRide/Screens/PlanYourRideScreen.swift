//
//  PlanYourRideScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI

import SwiftUI

struct TripDestination: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let distance: String
    let icon: String
}

struct PlanYourRideScreen: View {
    @State private var pickupLocation: String = "1200 Richmond Ave, Houston TX 77042"
    @State private var destination: String = ""

    let recentDestinations: [TripDestination] = [
        TripDestination(name: "Champion Automotive", address: "14106 Stuebner Airline Rd, Houston, TX", distance: "3.3 mi", icon: "clock"),
        TripDestination(name: "George Bush Intercontinental Airport (IAH)", address: "2800 N Terminal Rd, Houston, TX", distance: "13 mi", icon: "airplane.departure"),
        TripDestination(name: "Terminal D", address: "Level 2 Gates D1 - D12, George Bush Intercontinental", distance: "14 mi", icon: "clock"),
        TripDestination(name: "William P. Hobby Airport (HOU)", address: "7800 Airport Blvd, Houston, TX", distance: "32 mi", icon: "airplane.departure"),
        TripDestination(name: "Safe Tech Auto Glass", address: "15825 State Highway 249, Houston, TX", distance: "2.4 mi", icon: "clock")
    ]

    var body: some View {
        VStack {
          
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 50)
                    .overlay(
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.blue)
                            TextField("Pickup location", text: $pickupLocation)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.leading, 5)
                        }
                        .padding(.horizontal)
                    )

                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 50)
                    .overlay(
                        HStack {
                            Image(systemName: "square.fill")
                                .foregroundColor(.black)
                            TextField("Where to?", text: $destination)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.leading, 5)
                        }
                        .padding(.horizontal)
                    )
            }
            .padding(.horizontal)

            List(recentDestinations) { destination in
                HStack {
                    Image(systemName: destination.icon)
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.address)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(destination.distance)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Plan your ride")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NavigationStack {
        PlanYourRideScreen()
    }
}
