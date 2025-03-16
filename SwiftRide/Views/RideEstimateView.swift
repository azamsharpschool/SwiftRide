//
//  RideEstimateView.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/16/25.
//

import SwiftUI

struct RideEstimateView: View {
    
    let rideEstimate: RideEstimate
    var onInfoSelected: () -> Void = { }
    
    var body: some View {
        HStack {
            Image(systemName: rideEstimate.icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack {
                    Text(rideEstimate.title)
                        .fontWeight(.bold)
                    Image(systemName: "person.fill")
                    Text("\(rideEstimate.passengerCapacity)")
                    Spacer()
                    Text(rideEstimate.estimatedFare, format: .currency(code: "USD"))
                        .font(.title)
                        
                }
                Text("Arrival Time")
                    .font(.subheadline)
                    .foregroundColor(.gray)
               
                HStack {
                    Text(rideEstimate.description)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "info.circle.fill")
                        .onTapGesture(perform: onInfoSelected)
                }
              
            }
            
            Spacer()
        }
        .padding()
        .cornerRadius(10)
        .contentShape(Rectangle())
    }
}

#Preview {
    RideEstimateView(rideEstimate: PreviewData.rideEstimates[0])
    RideEstimateView(rideEstimate: PreviewData.rideEstimates[1])
}

/*
 struct RideOptionRow: View {
     let ride: RideEstimate
     let isSelected: Bool
     
     var body: some View {
         HStack {
             Image(systemName: "")
                 .font(.title)
                 .foregroundColor(.white)
                 .frame(width: 50, height: 50)
                 .background(Color.gray.opacity(0.3))
                 .clipShape(Circle())

             VStack(alignment: .leading) {
                 HStack {
                    // Text(ride.name)
                      //   .fontWeight(.bold)
                     Image(systemName: "person.fill")
                    // Text("\(ride.passengers)")
                 }
                 Text("Arrival Time")
                     .font(.subheadline)
                     .foregroundColor(.gray)
                 Text("Ride description")
                     .font(.footnote)
                     .foregroundColor(.gray)
             }
             
             Spacer()
             
             /*
             VStack(alignment: .trailing) {
                 if let discount = ride.discountedPrice {
                     Text(discount)
                         .foregroundColor(.green)
                     Text(ride.price)
                         .strikethrough()
                         .foregroundColor(.gray)
                         .font(.footnote)
                 } else {
                     Text(ride.price)
                         .fontWeight(.bold)
                 }
             } */
         }
         .padding()
         .background(isSelected ? Color.white.opacity(0.2) : Color.clear)
         .cornerRadius(10)
     }
 }
 */
