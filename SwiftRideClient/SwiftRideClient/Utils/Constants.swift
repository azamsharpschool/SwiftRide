//
//  Constants.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let register = URL(string: "http://localhost:8080/api/auth/register")!
        static let login = URL(string: "http://localhost:8080/api/auth/login")!
        static let refreshToken = URL(string: "http://localhost:8080/api/auth/refresh")!
        static let updateDriverStatus = URL(string: "http://localhost:8080/api/drivers/me/update-status")!
        static let serviceTypes = URL(string: "http://localhost:8080/api/service-types")!
    }
    
}
