import SwiftUI
import Supabase

struct UserRegistration {
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var selectedRole: Role = .rider
    var rating: Int?
    var termsAccepted: Bool = false
    var serviceOption: ServiceOption = .comfort
    var licensePlate: String = ""
    var make: String = ""
    var model: String = ""
    
    var isValid: Bool {
        !fullName.isEmptyOrWhitespace &&
        email.isEmail &&
        phoneNumber.isPhone &&
        !password.isEmptyOrWhitespace &&
        termsAccepted
    }
}

struct RegisterScreen: View {
    
    @Environment(SwiftRideStore.self) private var swiftRideStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var message: String?
    @State private var registerForm = UserRegistration()
    
    private func register() async {
        do {
            try await swiftRideStore.register(userRegistration: registerForm)
            dismiss()
            
        } catch {
            message = error.localizedDescription
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Create an Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Sign up to start your ride with SwiftRide.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Form {
                    Section {
                        TextField("Full Name", text: $registerForm.fullName)
                            .textContentType(.name)
                            .autocapitalization(.words)
                        
                        TextField("Email", text: $registerForm.email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        TextField("Phone Number", text: $registerForm.phoneNumber)
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                        
                        SecureField("Password", text: $registerForm.password)
                            .textContentType(.newPassword)
                            
                    }
                    
                    Section {
                        Picker("Register as:", selection: $registerForm.selectedRole) {
                            ForEach(Role.allCases) { role in
                                Text(role.title).tag(role)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    if registerForm.selectedRole == .driver {
                        Picker("Service Option:", selection: $registerForm.serviceOption) {
                                ForEach(ServiceOption.allCases) { serviceOption in
                                    Text(serviceOption.title).tag(serviceOption)
                                }
                        }
                        TextField("License Plate", text: $registerForm.licensePlate)
                        
                        TextField("Make", text: $registerForm.make)
                        TextField("Model", text: $registerForm.model)
                    }
                    
                    Section {
                        Toggle("I agree to the Terms & Conditions", isOn: $registerForm.termsAccepted)
                            .font(.subheadline)
                    }
                    
                    Section {
                        Button {
                            Task { await register() }
                        } label: {
                            Text("Register")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        //.disabled(!registerForm.isValid)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                
                if let message {
                    Text(message)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RegisterScreen()
        .environment(SwiftRideStore(client: .development))
}
