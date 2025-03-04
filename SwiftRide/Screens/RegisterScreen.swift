import SwiftUI
import Supabase

struct RegisterScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @State private var message: String?
    
    private struct RegisterForm {
        var fullName: String = "Mohammad Azam"
        var email: String = "azamsharp@gmail.com"
        var phoneNumber: String = "281-857-3727"
        var password: String = "password"
        var selectedRole: Role = .rider
        var termsAccepted: Bool = false
        
        var isValid: Bool {
            return !fullName.isEmptyOrWhitespace &&
            email.isEmail &&
            phoneNumber.isPhone &&
            !password.isEmptyOrWhitespace &&
            termsAccepted
        }
    }
    
    @State private var registerForm = RegisterForm()
    
    private func register() async {
        do {
            try await swiftRideStore.register(name: registerForm.fullName,
                                              email: registerForm.email,
                                              password: registerForm.password,
                                              phone: registerForm.phoneNumber,
                                              role: registerForm.selectedRole)
            
        } catch {
            message = error.localizedDescription
        }
    }
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                // Full Name
                TextField("Full Name", text: $registerForm.fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Email
                TextField("Email", text: $registerForm.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Phone Number
                TextField("Phone Number", text: $registerForm.phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.phonePad)
                
                // Password
                SecureField("Password", text: $registerForm.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Role Picker
                Picker("Register as:", selection: $registerForm.selectedRole) {
                    ForEach(Role.allCases) { role in
                        Text(role.title)
                            .tag(role)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Terms & Conditions Toggle
                Toggle("Accept Terms & Conditions", isOn: $registerForm.termsAccepted)
                    .padding(.horizontal)
                
                // Register Button
                Button(action: {
                    Task {
                        await register()
                    }
                }) {
                    Text("Register")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(registerForm.isValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(!registerForm.isValid) // Disable button if terms are not accepted
                
                if let message {
                    Text(message)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.red)
                        .padding()
                }
                
                Spacer()
            }.navigationTitle("Register")
        }
       
    }
}


#Preview {
    RegisterScreen()
        .environment(SwiftRideStore(client: .development))
}
