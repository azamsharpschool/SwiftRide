//
//  SwiftRideApp.swift
//  SwiftRide
//
//  Created by Mohammad Azam on 2/17/25.
//

import SwiftUI
import Supabase

@main
struct SwiftRideApp: App {
    
    @State private var router = Router()
    @State private var signInStatus: SignInStatus = .idle
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://xjhidioitjxkstusjldr.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqaGlkaW9pdGp4a3N0dXNqbGRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4Mzg3MTksImV4cCI6MjA1NTQxNDcxOX0.1vyOMEioRKVGIET4ee20pXoDZkkSOF8AnnZV8Uss71g")
    @State private var isAuthenticated: Bool = false
    
    private enum SignInStatus {
          case idle
          case signedIn
          case signedOut
      }
    
    private func listenAuthEvents() async {
           
        for await (event, _) in client.auth.authStateChanges {
               
               if case .initialSession = event {
                  
                   do {
                       let _ = try await client.auth.session
                       print("already sign in")
                       signInStatus = .signedIn
                   } catch let error as AuthError {
                       print(error)
                       signInStatus = .signedOut
                   } catch {
                       print(error)
                       signInStatus = .signedOut
                   }
               }
               
               if case .signedIn = event {
                   print("take the user to home screen")
                   // take the user to home screen
                   router.routes.append(.home)
                   signInStatus = .signedIn
               }
               
               if case .signedOut = event {
                   print("take the user to login screen")
                   // take the user to login screen
                   router.routes = []
                   signInStatus = .signedOut
               }
               
           }
       }
    

    var body: some Scene {
        WindowGroup {
            
            Group {
                switch signInStatus {
                    case .idle:
                        ProgressView("Loading...")
                    case .signedIn:
                        SwiftRideTabBarScreen()
                    case .signedOut:
                        LoginScreen()
                }
            }
            .environment(SwiftRideStore(client: client))
            .task {
                await listenAuthEvents()
            }
        }
    }
}
