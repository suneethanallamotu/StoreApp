//
//  StoreHttpClient.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/23/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case decodingError
    case invalidServerResponse
    case invalidURL
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var header: [String:String] = [:] //["Content-Type": "application/json"]
    var method: HTTPMethod = .get([])
}



class StoreHttpclient {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.header
        request.httpMethod = resource.method.name
        
        switch resource.method {
            
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw NetworkError.badURL
            }
            request.url = url
        case .post(let data):
            request.httpBody = data
            //break
        case .delete:
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        let session = URLSession(configuration: configuration)
        
        let(data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
    func getCategories(url: URL) async throws -> [Category] {
        let(data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodingError
        }
        return categories
    }
    
    func getProductsByCategory(url: URL) async throws -> [Product] {
        let(data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingError
        }
        return products
    }
    
//    func getAll<T>(url: URL) async throws -> [T] {
//        let(data,response) = try await URLSession.shared.data(from: URL)
//        guard (response as? HTTPURLResponse).statusCode == 200 else {
//            throw NetworkError.invalidResponse
//        }
//        guard let decodedData = try? JSONDecoder().decode([<T>].self, from: data) else {
//            throw NetworkError.decodingError
//        }
//        return decodedData
//    }
}
