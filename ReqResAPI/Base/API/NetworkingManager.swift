//
//  NetworkingManager.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 31.10.23.
//

import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(_ endpoint:Endpoint,
                             type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from:url, methodType: endpoint.methodType)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                throw NetworkingError.invalidStatusCode(statusCode: statusCode)
              }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        return res
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager {
    func buildRequest(from url:URL, methodType:Endpoint.MethodType) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
                request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
