//
//  LoginScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 2/17/26.
//

import SwiftUI

struct LoginScreen: View {

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isAuthenticating: Bool = false
    
    @State private var presentRegisterScreen: Bool = false
    
    @Environment(AuthenticationStore.self) private var authenticationStore
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func login() async {
        
        do {
            
            errorMessage = nil
            isAuthenticating = true
            defer { isAuthenticating = false }
            
            let response = try await authenticationStore.login(username: username, password: password)
            if !response.success {
                errorMessage = response.message
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
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
                            Text("welcome back")
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundStyle(.white.opacity(0.7))

                            Text("login")
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color(red: 0.44, green: 0.86, blue: 0.36))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.white.opacity(0.08), in: Capsule())
                        }
                    }

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
                    }

                    Button {
                       Task { await login() }
                    } label: {
                        HStack {
                            Text(isAuthenticating ? "Logging in..." : "Login")
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
                        Text(errorMessage.isEmpty ? "Login failed." : errorMessage)
                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color(red: 1.0, green: 0.45, blue: 0.35))
                            .padding(12)
                            .background(Color.red.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                    }
                    
                    HStack {
                        Text("New here?")
                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.6))
                        Button("Create account") {
                            presentRegisterScreen = true
                        }
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color(red: 0.44, green: 0.86, blue: 0.36))
                    }
                    .padding(.top, 4)

                    Spacer(minLength: 12)
                }
                .padding(24)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .sheet(isPresented: $presentRegisterScreen, content: {
            NavigationStack {
                RegisterScreen()
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LoginScreen()
        .environment(AuthenticationStore(httpClient: HTTPClient()))
}
