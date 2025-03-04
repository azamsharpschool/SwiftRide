//
//  Models.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/2/25.
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

struct Trip: Identifiable, Equatable {
    let id = UUID()
    var pickup: String = ""
    var destination: String = ""
}


enum Role: Int, Identifiable, CaseIterable {
    
    case rider = 1
    case driver = 2
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .rider:
                return "Rider"
            case .driver:
                return "Driver"
        }
    }
}
