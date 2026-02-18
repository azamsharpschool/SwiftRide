//
//  AuthenticationController.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import Foundation

struct AuthenticationController {
    
    // create HTTPClientProtocol if needed to mock
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        let body = ["username": username, "password": password]
        let bodyData = try JSONEncoder().encode(body)
        let resource = Resource(url: Constants.Urls.login, method: .post(bodyData), modelType: LoginResponse.self)
        let loginResponse = try await httpClient.load(resource)
        
        if let token = loginResponse.token,
           let userId = loginResponse.userId, loginResponse.success {
            // save token in the keychain
            Keychain.set(token, forKey: "jwttoken")
            // update the user defaults
            UserDefaults.standard.set(true, forKey: "isAuthenticated")
            UserDefaults.standard.set(userId, forKey: "userId")
        }

        return loginResponse
    }
    
    func register(_ request: RegisterRequest) async throws -> RegisterResponse {
        
        let body = try JSONEncoder().encode(request)
        let resource = Resource(url: Constants.Urls.register, method: .post(body), modelType: RegisterResponse.self)
        return try await httpClient.load(resource)
    }
    
    func logout() {
        // remove from keychain
        _ = Keychain<String>.delete("jwttoken")
        // update isAuthentication in UserDefaults
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
}
