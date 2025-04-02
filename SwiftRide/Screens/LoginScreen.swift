import SwiftUI

struct LoginScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistrationScreen: Bool = false
    @State private var loggingIn: Bool = false
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    
    private func login() async {
        do {
            loggingIn = true
            try await swiftRideStore.login(email: email, password: password)
            loggingIn = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Spacer(minLength: 40)
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                Text("Get moving with SwiftRide.\nSign in to continue.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
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
                    
                    Button("Forgot Password?") {
                        // Forgot password action
                    }
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 8)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .overlay(alignment: .center, content: {
                if loggingIn {
                    ProgressView("Logging In...")
                }
            })
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showRegistrationScreen) {
                RegisterScreen()
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environment(SwiftRideStore(client: .development))
}
