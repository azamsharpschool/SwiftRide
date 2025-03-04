//
//  String+Extensions.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/2/25.
//

import Foundation

extension String {
    
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Checks if the string is a valid email format.
    var isEmail: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /// Checks if the string is a valid phone number in the format XXX-XXX-XXXX.
    var isPhone: Bool {
        let phoneRegex = #"^\d{3}-\d{3}-\d{4}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
}




