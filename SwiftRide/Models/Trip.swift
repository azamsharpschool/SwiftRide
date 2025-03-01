//
//  Trip.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import Foundation

struct Trip: Identifiable {
    let id = UUID()
    let destination: String
    let address: String
    let icon: String
}
