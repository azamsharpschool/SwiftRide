
//
//  HTTPClient.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 5/7/23.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String?
}

enum NetworkError: Error {
    case badRequest
    case decodingError(Error)
    case invalidResponse
    case errorResponse(ErrorResponse, statusCode: Int)
    case unexpectedStatusCode(Int, Data)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Bad Request (400): Unable to perform the request.", comment: "badRequestError")
            case .decodingError(let error):
                return NSLocalizedString("Unable to decode successfully. \(error)", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response.", comment: "invalidResponse")
            case .errorResponse(let errorResponse, let statusCode):
                return NSLocalizedString("Error \(statusCode): \(errorResponse.message ?? "")", comment: "Error Response")
            case .unexpectedStatusCode(let statusCode, _):
                return NSLocalizedString("Unexpected status code: \(statusCode).", comment: "Unexpected Status Code")
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
            case .put:
                return "PUT"
        }
    }

    var body: Data? {
        switch self {
            case .post(let data), .put(let data):
                return data
            case .get, .delete:
                return nil
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
            case .get(let items):
                return items
            case .post, .put, .delete:
                return nil
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
    var modelType: T.Type
}

struct EmptyResponse: Codable { }

struct HTTPClient {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let defaultHeaders: [String: String]
    
    init(
        session: URLSession? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        defaultHeaders: [String: String] = ["Content-Type": "application/json"]
    ) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        self.session = session ?? URLSession(configuration: configuration)
        self.decoder = decoder
        self.defaultHeaders = defaultHeaders
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        // Set HTTP method and body if needed
        request.httpMethod = resource.method.name
        request.httpBody = resource.method.body
        if let queryItems = resource.method.queryItems {
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badRequest
            }
            request.url = url
        }
        
        // get the value from keychain
        let token: String? = Keychain.get("jwttoken")
        if let token {
            request.setValue(token, forHTTPHeaderField: "jwttoken")
        }
        
        // Set custom headers
        for (key, value) in defaultHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check for specific HTTP errors
        switch httpResponse.statusCode {
            case 200...299:
                break // Success
            default:
                if let errorResponse = try? decoder.decode(ErrorResponse.self, from: data) {
                    throw NetworkError.errorResponse(errorResponse, statusCode: httpResponse.statusCode)
                }
                throw NetworkError.unexpectedStatusCode(httpResponse.statusCode, data)
        }
        
        do {
            if data.isEmpty, T.self == EmptyResponse.self {
                return EmptyResponse() as! T
            }
            let result = try decoder.decode(resource.modelType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

extension HTTPClient {
    
    static var development: HTTPClient {
        HTTPClient()
    }
    
}
