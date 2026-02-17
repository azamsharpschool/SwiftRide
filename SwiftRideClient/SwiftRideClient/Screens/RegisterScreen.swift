//
//  RegisterScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/16/26.
//

import SwiftUI

struct RegisterScreen: View {
    
    @State private var username: String = "johndoe"
    @State private var password: String = "password"
    @State private var role: Role = .driver
    @State private var make: String = ""
    @State private var model: String = ""
    @State private var licensePlate: String = ""
    @State private var errorMessage: String?
    @State private var isAuthenticating: Bool = false
    
    @Environment(\.authenticationController) private var authenticationController
    
    private func register() async {
        
        do {
            errorMessage = nil
            isAuthenticating = true
            defer { isAuthenticating = false }
            
            let registerRequest = RegisterRequest(username: username, password: password, roleId: role.id, make: make, model: model, licensePlate: licensePlate)
            
            let response = try await authenticationController.register(registerRequest)
            
            if !response.success {
                errorMessage = response.message
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    var body: some View {
        Form {
            
            Picker("Select role", selection: $role) {
                ForEach(Role.allCases) { role in
                    Text(role.title)
                        .tag(role)
                }
            }.pickerStyle(.segmented)
            
            TextField("User name", text: $username)
                .textInputAutocapitalization(.never)
                .textContentType(.username)
            SecureField("Password", text: $password)
                .textContentType(.password)
            
            if role == .driver {
                TextField("Make", text: $make)
                TextField("Model", text: $model)
                TextField("License plate", text: $licensePlate)
            }
            
            Button("Register") {
                Task { await register() }
            }.disabled(!isFormValid || isAuthenticating)
            
            if let errorMessage {
                Text(errorMessage.isEmpty ? "Registration failed." : errorMessage)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    RegisterScreen()
}
