//
//  RecentTripView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI

// MARK: - Recent Locations
struct RecentTripView: View {
    let destination: String
    let address: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.green)
            VStack(alignment: .leading) {
                Text(destination)
                    .font(.system(size: 16, weight: .bold))
                Text(address)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RecentTripView(destination: "McDonalds Burger", address: "1200 Richmond Ave, Houston, TX 77042", icon: "clock")
}
