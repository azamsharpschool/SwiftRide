//
//  Trip.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import Foundation

struct Trip: Identifiable, Equatable {
    let id = UUID()
    var pickup: String = ""
    var destination: String = ""
}
