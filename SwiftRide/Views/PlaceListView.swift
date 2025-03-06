//
//  PlaceListView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/5/25.
//

import SwiftUI

struct PlaceListView: View {
    
    let places: [Place]
    let onSelect: (Place) -> Void
    
    var body: some View {
        List(places) { place in
            PlaceView(place: place)
                .onTapGesture {
                    onSelect(place)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    PlaceListView(places: [], onSelect: { _ in })
}
