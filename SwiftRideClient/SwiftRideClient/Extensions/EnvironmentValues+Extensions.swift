//
//  EnvironmentValues+Extensions.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import Foundation
import SwiftUI 

extension EnvironmentValues {
    
    @Entry var authenticationController = AuthenticationController(httpClient: .development)
    
}
