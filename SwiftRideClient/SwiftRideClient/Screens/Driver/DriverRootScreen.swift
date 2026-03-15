//
//  DriverRootScreen.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/14/26.
//

import SwiftUI

struct DriverRootScreen: View {
    var body: some View {
        TabView {
            DriverHomeScreen()
                .tabItem {
                    Label("Home", systemImage: "car.fill")
                }

            DriverSettingScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    DriverRootScreen()
}
