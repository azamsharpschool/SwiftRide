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
    
    private enum FocusedField {
        case pickup
        case destination
    }
    
    @State private var pickupLocation: String = ""
    @State private var destination: String = ""
    @FocusState private var focusedField: FocusedField?
    @State private var showChooseARideScreen: Bool = false
 
    let places: [Place] = [
        Place(name: "Golden Gate Bridge", subTitle: "San Francisco, CA"),
        Place(name: "Central Park", subTitle: "New York, NY"),
        Place(name: "Eiffel Tower", subTitle: "Paris, France"),
        Place(name: "Big Ben", subTitle: "London, UK"),
        Place(name: "Sydney Opera House", subTitle: "Sydney, Australia")
    ]

    let locationSearchService = LocationSearchService()
    
    var body: some View {
        
        let places = locationSearchService.places
        
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
                                .focused($focusedField, equals: .pickup)
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
                                .focused($focusedField, equals: .destination)
                        }
                        .padding(.horizontal)
                    )
            }
            .padding(.horizontal)

            List(places) { place in
                PlaceView(place: place)
                    .onTapGesture {
                        switch focusedField {
                            case .pickup:
                                pickupLocation = place.address
                            case .destination:
                                destination = place.address
                                showChooseARideScreen = true
                            default:
                                break
                        }
                    }
            }
            .listStyle(PlainListStyle())
        }
        .task(id: destination, {
            try? await Task.sleep(for: .seconds(1.0))
            locationSearchService.searchLocation(search: destination)
        })
        .task(id: pickupLocation, {
            try? await Task.sleep(for: .seconds(1.0))
            locationSearchService.searchLocation(search: pickupLocation)
        })
        .navigationTitle("Plan your ride")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showChooseARideScreen) {
            ChooseARideScreen() 
        }
        
    }
}


#Preview {
    NavigationStack {
        PlanYourRideScreen()
    }
}
