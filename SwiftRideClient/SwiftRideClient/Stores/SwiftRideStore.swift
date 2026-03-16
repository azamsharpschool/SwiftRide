//
//  SwiftRideStore.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/14/26.
//

import Foundation
import Observation

@Observable
class SwiftRideStore {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getAvailableServiceTypes() async throws -> [ServiceType] {
        let resource = Resource(url: Constants.Urls.availableServiceTypes, modelType: [ServiceType].self)
        return try await httpClient.load(resource)
    }
    
    func getServiceTypes() async throws -> [ServiceType] {
        let resource = Resource(url: Constants.Urls.serviceTypes, modelType: [ServiceType].self)
        return try await httpClient.load(resource)
    }
    
    func updateDriverStatus(isOnline: Bool) async throws {
        
        let body = ["isOnline": isOnline]
        
        let resource = Resource(url: Constants.Urls.updateDriverStatus, method: .patch(try JSONEncoder().encode(body)), modelType: APIResponse.self)
        let response = try await httpClient.load(resource)
        
        guard response.success else {
            throw NetworkError.serverError(response.message ?? "Unable to update the driver.")
        }
        
        UserDefaults.standard.set(isOnline, forKey: "isOnline")
    }
    
}
