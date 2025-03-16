//
//  FarebreakdownScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/16/25.
//

import SwiftUI

struct FarebreakdownScreen: View {
    
    @Environment(\.dismiss) private var dismiss 
    let serviceOption: ServiceOption
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Subtitle
            Text("Your fare will be the price presented before the trip or based on the rates below and other applicable surcharges and adjustments.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .navigationTitle("Fare Breakdown")
            
            Divider()
            
            FareRow(title: "Base Fare", value: serviceOption.baseFare)
            
            FareRow(title: "Cost Per Mile", value: serviceOption.costPerMile)
            
            FareRow(title: "Cost Per Minute", value: serviceOption.costPerMinute)
            
            // Additional Notes
            Text("Additional wait time charges may apply to your trip if the driver has waited 2 minute(s)")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top)
            
            Spacer()
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        })
        .padding()
    }
}

struct FareRow: View {
    
    let title: String
    let value: Double
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value, format: .currency(code: "USD"))
                .font(.headline)
                .fontWeight(.semibold)
        }
        Divider()
    }
}

#Preview {
    NavigationStack {
        FarebreakdownScreen(serviceOption: .comfort)
    }
}
