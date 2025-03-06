//
//  PlanYourRideScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI
import MapKit

// Example supporting models
enum TripField {
    case pickup, destination
}

struct PlanYourRideScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @Environment(LocationManager.self) private var locationManager
    
    @State private var trip = Trip()
    @State private var activeField: TripField?
    
    let locationSearchService = LocationSearchService()
    @State private var activeSheet: PlanYourRideSheets?
    
    private enum PlanYourRideSheets: Identifiable {
        case inputLocation // For pickup and destination input
        case chooseARide  // For choosing a ride
        
        var id: Int {
            switch self {
            case .inputLocation:
                return 1
            case .chooseARide:
                return 2
            }
        }
    }
    
    var locationInputView: some View {
        VStack {
            VStack(spacing: 12) {
                // Pickup TextField
                LocationTextField(
                    placeholder: "Pickup location",
                    text: $trip.pickup,
                    iconName: "circle.fill",
                    iconColor: .blue,
                    onTap: {
                        withAnimation {
                            activeField = .pickup
                        }
                    },
                    onChange: { value in
                        locationSearchService.searchLocation(search: value)
                    }
                )
                
                // Destination TextField
                LocationTextField(
                    placeholder: "Destination",
                    text: $trip.destination,
                    iconName: "circle.fill",
                    iconColor: .black,
                    onTap: {
                        activeField = .destination
                    },
                    onChange: { value in
                        locationSearchService.searchLocation(search: value)
                    }
                )
            }
            .padding(.horizontal)
    
        }
        .padding()
        .presentationDetents([.large])
    }
    
    var body: some View {
        
        @Bindable var locationManager = self.locationManager
        let places = locationSearchService.places
        
        VStack {
            Text("Nearby Drivers \(swiftRideStore.nearbyDrivers.count)")
            Map(position: $locationManager.cameraPosition) {
                UserAnnotation()
            }
            
        }
        .onAppear(perform: {
            activeSheet = .inputLocation
        })
        .sheet(item: $activeSheet, content: { sheet in
            Group {
                switch sheet {
                    case .inputLocation:
                        VStack {
                            locationInputView
                            PlaceListView(places: places) { place in
                                switch activeField {
                                    case .pickup:
                                        trip.pickup = place.address
                                    case .destination:
                                        trip.destination = place.address
                                        activeSheet = .chooseARide
                                    default:
                                        break
                                }
                            }
                        }
                       
                    case .chooseARide:
                        ChooseARideScreen()
                }
            }
            .presentationDetents([.medium, .large])
            //.interactiveDismissDisabled()
            
        })
        
        .task {
            
            locationManager.requestLocation()
            
            do {
                try await swiftRideStore.loadNearbyDrivers()
                try await swiftRideStore.startListeningForNearbyDrivers()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        .navigationTitle("Plan your ride")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}


#Preview {
    NavigationStack {
        PlanYourRideScreen()
    }
    .environment(SwiftRideStore(client: .development))
    .environment(LocationManager())
}
