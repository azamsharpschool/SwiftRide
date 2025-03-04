//
//  LoginScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistrationScreen: Bool = false
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    
    private func login() async {
        do {
            try await swiftRideStore.login(email: email, password: password)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                
                Text("Get moving with SwiftRide. Sign in to continue.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Form {
                    Section {
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                        
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    }
                    
                    Section {
                        Button(action: {
                            Task { await login() }
                        }) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button(action: {
                            showRegistrationScreen = true
                        }) {
                            Text("Register")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: {
                            // Forgot password action
                        }) {
                            Text("Forgot Password?")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                .sheet(isPresented: $showRegistrationScreen) {
                    RegisterScreen()
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginScreen()
        .environment(SwiftRideStore(client: .development))
}
