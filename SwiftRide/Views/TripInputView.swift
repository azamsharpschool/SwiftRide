//
//  TripInputView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/5/25.
//

import SwiftUI

struct TripInputView: View {
    @Binding var trip: Trip
    @FocusState.Binding var focusedField: TripField?

    var body: some View {
        VStack {
            LocationInputField(icon: "circle.fill", placeholder: "Pickup location", text: $trip.pickup, color: .blue, focusedField: $focusedField, field: .pickup)

            LocationInputField(icon: "square.fill", placeholder: "Where to?", text: $trip.destination, color: .black, focusedField: $focusedField, field: .destination)

            //PlaceListView(places: places, trip: $trip, focusedField: $focusedField)
        }
    }
}

struct LocationInputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    let color: Color
    @FocusState.Binding var focusedField: TripField?
    let field: TripField

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)
                    TextField(placeholder, text: $text)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.leading, 5)
                        .focused($focusedField, equals: field)
                }
                .padding(.horizontal)
            )
    }
}

struct PlaceListView: View {
    let places: [Place]
    @Binding var trip: Trip
    @FocusState.Binding var focusedField: TripField?
    @State private var showChooseARideScreen = false

    var body: some View {
        List(places) { place in
            PlaceView(place: place)
                .onTapGesture {
                    switch focusedField {
                    case .pickup:
                        trip.pickup = place.address
                    case .destination:
                        trip.destination = place.address
                        showChooseARideScreen = true
                    default:
                        break
                    }
                }
        }
    }
}

#Preview {
    //TripInputView(trip: .constant(Trip(), focusedField: .constant()))
}
