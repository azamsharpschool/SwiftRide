//
//  PlanYourRideScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI
import MapKit

struct TripDestination: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let distance: String
    let icon: String
}

// Example supporting models
enum TripField {
    case pickup, destination
}

struct PlanYourRideScreen: View {
    
    @Environment(LocationManager.self) private var locationManager
    
    @State private var showChooseARideScreen: Bool = false
    @State private var trip = Trip()
    @State private var activeField: TripField?
    
    let locationSearchService = LocationSearchService()
    
    var body: some View {
        
        let places = locationSearchService.places
        
        VStack {
            
            Map {
                
            }
            
        }
        .sheet(isPresented: .constant(true), content: {
            
            VStack {
                
                VStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: 50)
                        .overlay(
                            HStack {
                                Button(action: {
                                    activeField = .pickup
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.blue)
                                        TextField("Pickup location", text: $trip.pickup)
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .onChange(of: trip.pickup) {
                                                locationSearchService.searchLocation(search: trip.pickup)
                                            }
                                    }
                                }.buttonStyle(.plain)
                                
                            }
                            .padding(.horizontal)
                        )
                    
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: 50)
                        .overlay(
                            HStack {
                                Button(action: {
                                    activeField = .destination
                                }) {
                                    HStack {
                                        Image(systemName: "square.fill")
                                                .foregroundColor(.black)
                                        TextField("Where to?", text: $trip.destination)
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .onChange(of: trip.destination) {
                                                locationSearchService.searchLocation(search: trip.destination)
                                            }
                                    }
                                }.buttonStyle(.plain)
                                
                            }.padding(.horizontal)
                        )
                    
                }
                .padding(.horizontal)
                
                
                List(places) { place in
                    PlaceView(place: place)
                        .onTapGesture {
                            switch activeField {
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
            .padding()
            .presentationDetents([.medium])
        })
        .task {
            // find the user's location
            // locationManager.requestLocation()
        }
        
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
    }.environment(LocationManager())
}
