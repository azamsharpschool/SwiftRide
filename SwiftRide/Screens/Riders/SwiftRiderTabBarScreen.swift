//
//  VegetableTabBarScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/9/25.
//

import SwiftUI

struct SwiftRiderTabBarScreen: View {
    
    var body: some View {
        TabView {
            
            NavigationStack {
                RiderHomeScreen() 
            }.tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            NavigationStack {
                Text("Activity")
            }.tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Activity")
                }
            
            NavigationStack {
                SettingsScreen() 
            }.tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Account")
                }
            
        }
    }
}

#Preview {
    SwiftRiderTabBarScreen()
}
