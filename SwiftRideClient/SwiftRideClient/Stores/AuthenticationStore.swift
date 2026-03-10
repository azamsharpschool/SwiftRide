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
        
        if let accessToken = loginResponse.accessToken,
           let refreshToken = loginResponse.refreshToken,
           let userId = loginResponse.userId,
           let roleId = loginResponse.roleId, loginResponse.success {
            
            // save access token in the keychain
            Keychain.set(accessToken, forKey: "accessToken")
            Keychain.set(refreshToken, forKey: "refreshToken")
            
            // update the user defaults
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(roleId, forKey: "roleId")
            
            authenticationState = .authenticated
        }

        return loginResponse
    }
    
    func updateProfile() async throws {
    
        do {
            let url = URL(string: "http://localhost:8080/api/auth/secure-route")!
            let resource = Resource(url: url, modelType: SecureResponse.self)
            let _ = try await httpClient.load(resource)
        } catch NetworkError.unauthorized {
            logout()
        } catch {
            throw error 
        }
    
    }
    
    func register(_ request: RegisterRequest) async throws -> RegisterResponse {
        
        let body = try JSONEncoder().encode(request)
        let resource = Resource(url: Constants.Urls.register, method: .post(body), modelType: RegisterResponse.self)
        return try await httpClient.load(resource)
    }
    
    func logout() {
        // remove from keychain
        _ = Keychain<String>.delete("accessToken")
        // update isAuthentication in UserDefaults
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "roleId")
        authenticationState = .unauthenticated
    }
    
    func checkAuthentication() {
        guard let token: String = Keychain.get("accessToken") else {
            print("token is not in the keychain")
            logout()
            return
        }
        
        if JWTDecoder.isTokenExpired(token) {
            print("token is expired")
            logout()
        } else {
            authenticationState = .authenticated
        }
    }
    
}
 
