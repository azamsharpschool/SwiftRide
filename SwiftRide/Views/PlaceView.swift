//
//  PlaceView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/1/25.
//

import SwiftUI

struct PlaceView: View {
    
    let place: Place
    
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.headline)
                Text(place.subTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Text("12 mi")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    PlaceView(place: Place(name: "IAH Airport", subTitle: "1200 Richmond Ave, Houston, TX 77042"))
}
