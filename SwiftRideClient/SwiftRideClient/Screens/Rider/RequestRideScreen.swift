//
//  RequestRideScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/15/26.
//

import SwiftUI

struct RequestRideScreen: View {
    
    @State private var rideRequest = CreateRideRequest()
    @State private var currentIndex: Int = 0
    @State private var availableServiceTypes: [ServiceType] = []
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    
    let steps: [RequestRideStep] = [.whereTo, .serviceOptions]
    
    private var currentStep: RequestRideStep {
        steps[currentIndex]
    }
    
    @ViewBuilder
    private var currentStepView: some View {
        switch currentStep {
        case .whereTo:
            WhereToView(pickupAddress: $rideRequest.pickupAddress, destinationAddress: $rideRequest.destinationAddress)
        case .serviceOptions:
            ServiceOptionListView(serviceTypes: availableServiceTypes)
        }
    }
    
    enum RequestRideStep {
        case whereTo
        case serviceOptions
        
        var title: String {
            switch self {
            case .whereTo:
                return "Choose Ride"
            case .serviceOptions:
                return "Confirm Ride"
            }
        }
    }
    
    private var isFormValid: Bool {
        switch currentStep {
        case .whereTo:
            return !rideRequest.pickupAddress.isEmptyOrWhitespace && !rideRequest.destinationAddress.isEmptyOrWhitespace
        case .serviceOptions:
            return true
        }
    }
    
    var body: some View {
        
        Group {
            
            currentStepView
            
            Button(currentStep.title) {
                if currentIndex < steps.count - 1 {
                    currentIndex += 1
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(isFormValid ? .blue: .gray.opacity(0.4))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .disabled(!isFormValid)
        }
        .padding()
        .task {
            do {
                availableServiceTypes = try await swiftRideStore.getAvailableServiceTypes()
                print(availableServiceTypes) 
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RequestRideScreen()
    }.environment(SwiftRideStore(httpClient: .development))
}
