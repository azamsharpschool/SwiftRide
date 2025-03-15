//
//  RideOptionListView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/15/25.
//

import SwiftUI

struct RideOptionListView: View {
    
    let rideOptions: [RideOption]
    
    var body: some View {
        Text("Ride Option List View")
    }
}

#Preview {
    RideOptionListView(rideOptions: PreviewData.rideOptions)
}
