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
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button {
                // action
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)

        }
    }
}

#Preview {
    LoginScreen()
}
