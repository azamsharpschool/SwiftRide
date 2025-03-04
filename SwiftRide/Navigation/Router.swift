//
//  Router.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//


import Foundation
import Observation

enum Route {
    case login
    case home
}

@Observable
class Router {
    var routes: [Route] = []
}
