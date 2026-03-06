//
//  AuthenticationStore.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/6/26.
//

import Foundation
import Observation

@Observable
class AuthenticationStore {
    
    let httpClient: HTTPClient
    
    var authenticationState: AuthenticationState = .checking
    
    enum AuthenticationState {
        case checking
        case authenticated
        case unauthenticated
    }
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        let body = ["username": username, "password": password]
        let bodyData = try JSONEncoder().encode(body)
        let resource = Resource(url: Constants.Urls.login, method: .post(bodyData), modelType: LoginResponse.self)
        let loginResponse = try await httpClient.load(resource)
        
        if let token = loginResponse.token,
           let userId = loginResponse.userId,
           let roleId = loginResponse.roleId, loginResponse.success {
            
            authenticationState = .authenticated
            // save token in the keychain
            Keychain.set(token, forKey: "jwttoken")
            // update the user defaults
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(roleId, forKey: "roleId")
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
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "roleId")
        authenticationState = .unauthenticated
    }
    
    func checkAuthentication() {
        guard let token: String = Keychain.get("jwttoken") else {
            logout()
            return
        }
        
        if JWTDecoder.isTokenExpired(token) {
            logout()
        } else {
            authenticationState = .authenticated
        }
    }
    
}
 
