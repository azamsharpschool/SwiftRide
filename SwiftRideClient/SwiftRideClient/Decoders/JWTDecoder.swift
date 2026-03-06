//
//  JWTDecoder.swift
//  SwiftRideClient
//
//  Created by Mohammad Azam on 3/6/26.
//

import Foundation

struct JWTPayload: Decodable {
    let userId: Int?
    let iat: TimeInterval?
    let exp: TimeInterval?
}

enum JWTError: Error {
    case invalidToken
    case invalidPayload
}

struct JWTDecoder {
    
    static func isTokenExpired(_ token: String) -> Bool {
        do {
            let payload = try decodePayload(from: token)
            
            guard let exp = payload.exp else {
                return true
            }
            
            let expirationDate = Date(timeIntervalSince1970: exp)
            return Date() >= expirationDate
        } catch {
            return true
        }
    }
    
    static func decodePayload(from token: String) throws -> JWTPayload {
        let segments = token.split(separator: ".")
        guard segments.count == 3 else {
            throw JWTError.invalidToken
        }
        
        let payloadSegment = String(segments[1])
        let base64 = base64URLToBase64(payloadSegment)
        
        guard let data = Data(base64Encoded: base64) else {
            throw JWTError.invalidPayload
        }
        
        return try JSONDecoder().decode(JWTPayload.self, from: data)
    }
    
    private static func base64URLToBase64(_ base64URL: String) -> String {
        var base64 = base64URL
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let paddingLength = 4 - base64.count % 4
        if paddingLength < 4 {
            base64 += String(repeating: "=", count: paddingLength)
        }
        
        return base64
    }
}
