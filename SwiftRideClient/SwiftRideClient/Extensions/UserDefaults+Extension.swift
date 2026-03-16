//
//  UserDefaults+Extension.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/16/26.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let userSession = "userSession"
    }
    
    var userSession: UserSession? {
        get {
            guard let data = data(forKey: Keys.userSession) else {
                return nil
            }
            
            return try? JSONDecoder().decode(UserSession.self, from: data)
        }
        
        set {
            if let newValue {
                let data = try? JSONEncoder().encode(newValue)
                set(data, forKey: Keys.userSession)
            } else {
                removeObject(forKey: Keys.userSession)
            }
        }
    }
    
}
