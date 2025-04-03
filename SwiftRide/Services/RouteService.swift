//
//  RouteService.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 4/3/25.
//

import Foundation
import MapKit

struct RouteService {
    
    func calculateRoute(from: CLLocation, to: CLLocation) async ->  MKRoute? {
        
        let fromMapItem = MKMapItem(placemark: MKPlacemark(coordinate: from.coordinate))
        let toMapItem = MKMapItem(placemark: MKPlacemark(coordinate: to.coordinate))
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.transportType = .automobile
        directionsRequest.source = fromMapItem
        directionsRequest.destination = toMapItem
        
        let directions = MKDirections(request: directionsRequest)
        let response = try? await directions.calculate()
        return response?.routes.first
    }
    
}
