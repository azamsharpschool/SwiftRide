//
//  String+Extensions.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/17/26.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
