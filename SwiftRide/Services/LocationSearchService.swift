//
//  LocationSearchService.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/1/25.
//

import Foundation
import MapKit
import Observation

@Observable
class LocationSearchService: NSObject, MKLocalSearchCompleterDelegate {
    
    var places: [Place] = []
    private var localSearchCompleter: MKLocalSearchCompleter
    
    override init() {
        localSearchCompleter = MKLocalSearchCompleter()
        super.init()
        localSearchCompleter.delegate = self
    }
    
    func searchLocation(search: String) {
        guard !search.isEmpty else { return }
        localSearchCompleter.queryFragment = search
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        places = completer.results.map {
            Place(name: $0.title, subTitle: $0.subtitle)
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}


