//
//  RideOptionListView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/15/25.
//

import SwiftUI

struct RideEstimateListView: View {
    
    let rideEstimates: [RideEstimate]
    
    var body: some View {
        List(rideEstimates) { rideEstimate in
            Text(rideEstimate.title)
        }
    }
}

#Preview {
    RideEstimateListView(rideEstimates: PreviewData.rideEstimates)
}
