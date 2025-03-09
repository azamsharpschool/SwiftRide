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
    @State private var role: Role?
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://xjhidioitjxkstusjldr.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqaGlkaW9pdGp4a3N0dXNqbGRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4Mzg3MTksImV4cCI6MjA1NTQxNDcxOX0.1vyOMEioRKVGIET4ee20pXoDZkkSOF8AnnZV8Uss71g")
    @State private var isAuthenticated: Bool = false
    
    private enum SignInStatus {
        case idle
        case signedIn
        case signedOut
    }
    
    private func listenAuthEvents() async throws {
        
        for await (event, _) in client.auth.authStateChanges {
            
            switch event {
            case .initialSession, .signedIn:
                do {
                    
                    let user = try await client.auth.user()
                    let metadata = user.userMetadata
                    
                    guard let roleId = metadata["role_id"]?.intValue,
                          let role = Role(rawValue: roleId) else { return }
                    
                    self.role = role
                    signInStatus = .signedIn
                    
                } catch let error as AuthError {
                    print(error)
                    signInStatus = .signedOut
                } catch {
                    print(error)
                    signInStatus = .signedOut
                }
            case .signedOut:
                signInStatus = .signedOut
            default:
                break
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
                    switch role {
                    case .rider:
                        SwiftRiderTabBarScreen()
                            .task {
                                // load rider details 
                            }
                    case .driver:
                        SwiftDriverTabBarScreen()
                            .task {
                                // load driver details
                            }
                    default:
                        EmptyView()
                    }
                case .signedOut:
                    LoginScreen()
                }
            }
            .environment(SwiftRideStore(client: client))
            .environment(LocationManager())
            .task {
                do {
                    try await listenAuthEvents()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
