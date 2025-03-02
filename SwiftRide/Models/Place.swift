//
//  Place.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/1/25.
//

import Foundation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let subTitle: String
    
    var address: String {
        "\(name) \(subTitle)"
    }
}
