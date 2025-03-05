//
//  HomeScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI

struct RiderHomeScreen: View {
    
    @State private var search: String = ""
    @State private var showTripPlanningScreen: Bool = false
    
    var body: some View {
        VStack {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                Text("Where to?")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium))
                    .onTapGesture {
                        showTripPlanningScreen = true
                    }
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
            .padding(.horizontal)
            
            RecentLocationsView()
            
            Spacer()
        }
        .navigationDestination(isPresented: $showTripPlanningScreen) {
            PlanYourRideScreen() 
        }
        /*
        .sheet(isPresented: $showTripPlanningScreen) {
            NavigationStack {
                PlanYourRideScreen()
            }
        } */
    }
}

#Preview {
    NavigationStack {
        RiderHomeScreen()
    }
    .environment(SwiftRideStore(client: .development))
    .environment(LocationManager())
}
