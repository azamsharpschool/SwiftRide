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
    @State private var serviceType: ServiceType?
    @State private var errorMessage: String?
    @State private var isAuthenticating: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthenticationStore.self) private var authenticationStore
    @Environment(SwiftRideStore.self) private var swiftRideStore
    
    @State private var serviceTypes: [ServiceType] = []
    
    private func register() async {
        
        do {
            errorMessage = nil
            isAuthenticating = true
            defer { isAuthenticating = false }
            
            let registerRequest = RegisterRequest(
                username: username,
                password: password,
                roleId: role.id,
                make: role == .driver ? make : nil,
                model: role == .driver ? model : nil,
                licensePlate: role == .driver ? licensePlate : nil
            )
            
            let response = try await authenticationStore.register(registerRequest)
            
            if !response.success {
                errorMessage = response.message
            } else {
                dismiss()
            }
            
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private var isFormValid: Bool {
        let valid = !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
        if role == .driver {
            return valid
                && !make.isEmptyOrWhitespace
                && !model.isEmptyOrWhitespace
                && !licensePlate.isEmptyOrWhitespace
        }
        return valid
    }
    
    var body: some View {
        
            ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.06, blue: 0.08),
                    Color(red: 0.12, green: 0.13, blue: 0.16),
                    Color(red: 0.06, green: 0.10, blue: 0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftRide")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        HStack(spacing: 6) {
                            Text("Ride sharing app for Swift developers.")
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundStyle(.white.opacity(0.7))
                            
                            Text("</>")
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color(red: 0.44, green: 0.86, blue: 0.36))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.white.opacity(0.08), in: Capsule())
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Choose your lane")
                            .font(.system(size: 12, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.6))
                        
                        Picker("Select role", selection: $role) {
                            ForEach(Role.allCases) { role in
                                Text(role.title)
                                    .tag(role)
                            }
                        }
                        .pickerStyle(.segmented)
                        .tint(Color(red: 0.44, green: 0.86, blue: 0.36))
                    }
                    .padding(16)
                    .background(Color.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                    
                    VStack(spacing: 12) {
                        TextField("User name", text: $username)
                            .textInputAutocapitalization(.never)
                            .textContentType(.username)
                            .padding(14)
                            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                            .foregroundStyle(.white)
                            .tint(Color(red: 0.44, green: 0.86, blue: 0.36))
                        
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .padding(14)
                            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                            .foregroundStyle(.white)
                            .tint(Color(red: 0.44, green: 0.86, blue: 0.36))
                        
                        if role == .driver {
                            
                            Picker("Service Type", selection: $serviceType) {
                                ForEach(serviceTypes) { serviceType in
                                    Text(serviceType.name)
                                        .tag(serviceType)
                                }
                            }.pickerStyle(.segmented)
                            
                            TextField("Make", text: $make, prompt: Text("Make").foregroundStyle(.white.opacity(0.6)))
                                .padding(14)
                                .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                                .foregroundStyle(.white)
                                .tint(Color(red: 0.44, green: 0.86, blue: 0.36))
                            
                            TextField("Model", text: $model, prompt: Text("Model").foregroundStyle(.white.opacity(0.6)))
                                .padding(14)
                                .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                                .foregroundStyle(.white)
                                .tint(Color(red: 0.44, green: 0.86, blue: 0.36))
                            
                            TextField("License plate", text: $licensePlate, prompt: Text("License plate").foregroundStyle(.white.opacity(0.6)))
                                .textInputAutocapitalization(.characters)
                                .padding(14)
                                .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
                                .foregroundStyle(.white)
                                .tint(Color(red: 0.44, green: 0.86, blue: 0.36))
                        }
                    }
                    
                    Button {
                        Task { await register() }
                    } label: {
                        HStack {
                            Text(isAuthenticating ? "Registering..." : "Register")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                            Image(systemName: "arrow.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                    }
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 0.44, green: 0.86, blue: 0.36),
                                Color(red: 0.98, green: 0.54, blue: 0.24)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                    .foregroundStyle(.black)
                    .disabled(!isFormValid || isAuthenticating)
                    .opacity(isFormValid && !isAuthenticating ? 1.0 : 0.6)
                    
                    if let errorMessage {
                        Text(errorMessage.isEmpty ? "Registration failed." : errorMessage)
                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color(red: 1.0, green: 0.45, blue: 0.35))
                            .padding(12)
                            .background(Color.red.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Spacer(minLength: 12)
                }
                .padding(24)
            }
            .scrollDismissesKeyboard(.interactively)
            }.task {
                do { 
                    serviceTypes = try await swiftRideStore.getServiceTypes()
                    print(serviceTypes)
                    serviceType = serviceTypes[0]
                } catch {
                    print(error.localizedDescription)
                }
            }
        
    }
}

#Preview {
    NavigationStack {
        RegisterScreen()
    }
    .environment(AuthenticationStore(httpClient: .development))
    .environment(SwiftRideStore(httpClient: .development))
}
