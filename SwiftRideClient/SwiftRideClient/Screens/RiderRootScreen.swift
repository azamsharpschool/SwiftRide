//
//  RiderHomeScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/18/26.
//

import SwiftUI

struct RiderRootScreen: View {
    var body: some View {
        TabView {
            RiderHomeScreen()
                .tabItem {
                    Label("Home", systemImage: "map")
                }
            
            TripsTab()
                .tabItem {
                    Label("Trips", systemImage: "clock")
                }
            
            InboxTab()
                .tabItem {
                    Label("Inbox", systemImage: "bell")
                }
            
            AccountTab()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
            
            ExploreTab()
                .tabItem {
                    Label("Explore", systemImage: "sparkles")
                }
        }
    }
}

private struct RiderHomeScreen: View {
    
    @Environment(AuthenticationStore.self) private var authenticationStore
    
    var body: some View {
        Text("Ride Home")
    }
}

private struct TripsTab: View {
    var body: some View {
        Text("Your Trips")
    }
}

private struct InboxTab: View {
    var body: some View {
        Text("Activity")
    }
}

private struct AccountTab: View {
    var body: some View {
        Text("Account")
    }
}

private struct ExploreTab: View {
    var body: some View {
        Text("Explore")
    }
}

#Preview {
    RiderRootScreen()
        .environment(AuthenticationStore(httpClient: HTTPClient()))
}
