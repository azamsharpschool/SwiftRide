//
//  DriverHomeScreen.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 3/4/25.
//

import SwiftUI

struct DriverHomeScreen: View {
    
    @State private var isOnline: Bool = false
    
    var body: some View {
        VStack {
            Toggle("Online", isOn: $isOnline)
                .fixedSize()
            Spacer()
        }
    }
}

#Preview {
    DriverHomeScreen()
        .environment(SwiftRideStore(client: .development))
}
