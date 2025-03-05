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
    
    @FocusState private var focusedField: FocusedField?
    @State private var showChooseARideScreen: Bool = false
    @State private var trip = Trip()
 
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
                            TextField("Pickup location", text: $trip.pickup)
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
                            TextField("Where to?", text: $trip.destination)
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
                                trip.pickup = place.address
                            case .destination:
                                trip.destination = place.address
                                showChooseARideScreen = true
                            default:
                                break
                        }
                    }
            }
            .listStyle(PlainListStyle())
        }
        .task(id: trip, {
            try? await Task.sleep(for: .seconds(1.0))
            switch focusedField {
                case .pickup:
                    locationSearchService.searchLocation(search: trip.pickup)
                case .destination:
                    locationSearchService.searchLocation(search: trip.destination)
                default:
                    break
            }
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
