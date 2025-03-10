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
                        activeField = .pickup
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
                ForEach(swiftRideStore.nearbyDrivers) { driver in
                    
                    Annotation("Driver", coordinate: driver.coordinate) {
                        Image(systemName: "car.fill") // Use a car icon
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                            .background(Color.white)  
                            .clipShape(Circle())
                    }
                }
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
            .presentationDetents([.fraction(0.25), .medium, .large])
            .presentationBackgroundInteraction(
                .enabled(upThrough: .medium)
            )
            .interactiveDismissDisabled()
            
        })
        .onAppear(perform: {
            locationManager.requestLocation()
        })
       
        
        .task(id: locationManager.userLocation) {
            
            do {
                
                guard let userLocation = locationManager.userLocation else { return }
                let userCoordinate = userLocation.coordinate
                
                try await swiftRideStore.loadNearbyDriversBy(coordinate: userCoordinate)
                //try await swiftRideStore.startListeningForNearbyDrivers()
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
