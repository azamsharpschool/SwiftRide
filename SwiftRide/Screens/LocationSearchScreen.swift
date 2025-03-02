//
//  LocationSearchScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/1/25.
//

import SwiftUI
import MapKit
import CoreLocation
import Contacts

extension MKCoordinateRegion {
    // Dummy region for San Francisco
    static var sanFrancisco: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    // Dummy region for New York
    static var newYork: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    // Dummy region for London
    static var london: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    // Create a custom dummy region
    static func custom(center: CLLocationCoordinate2D, span: MKCoordinateSpan) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: center, span: span)
    }
}

struct LocationSearchScreen: View {
    
    @State private var search: String = ""
    private var locationSearchService = LocationSearchService()
    
    var body: some View {
        
        let places = locationSearchService.places
        
        VStack {
            TextField("Destination", text: $search)
                .padding()
            
            if !places.isEmpty && !search.isEmpty {
                List(places) { place in
                    VStack(alignment: .leading) {
                        Text(place.name)
                            .font(.headline)
                        Text(place.subTitle)
                    }
                }.listStyle(.plain)
            }
            
            Spacer()
        }
        .task(id: search) {
            try? await Task.sleep(for: .seconds(1))
            locationSearchService.searchLocation(search: search)
        }
    }
}

#Preview {
    LocationSearchScreen()
}
