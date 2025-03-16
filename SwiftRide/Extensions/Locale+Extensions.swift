//
//  Locale+Extensions.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/16/25.
//

import Foundation

extension Locale {
    
    var currencyIdentifier: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
}
