//
//  RequestRideScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/15/26.
//

import SwiftUI

struct RequestRideScreen: View {
    
    @State private var requestRideStep: RequestRideStep = .whereTo
    @State private var rideRequest = CreateRideRequest()
    
    enum RequestRideStep {
        case whereTo
        case serviceOptions
    }
    
    var body: some View {
        VStack {
            switch requestRideStep {
            case .whereTo:
                WhereToView(pickupAddress: $rideRequest.pickupAddress, destinationAddress: $rideRequest.destinationAddress)
            case .serviceOptions:
                Text("Service Options")
            }
            Button("Next") {
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        RequestRideScreen()
    }.environment(SwiftRideStore(httpClient: .development))
}
