//
//  Router.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//


import Foundation
import Observation

enum Route {
    
    case rider(RiderRoutes)
    case driver(DriverRoutes)
    
    case login
    case home
}

enum RiderRoutes {
    case home
}

enum DriverRoutes {
    case home
}


@Observable
class Router {
    var routes: [Route] = []
}
