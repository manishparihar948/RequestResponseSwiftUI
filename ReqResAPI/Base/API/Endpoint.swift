//
//  Endpoint.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 31.10.23.
//

import Foundation

enum Endpoint {
    case people(page:Int)
    case detail(id:Int)
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    var host: String {"reqres.in"}
    
    var path: String {
        switch self {
        case .people:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people, .detail:
            return .GET
        }
    }
    
    
    var queryItems: [String:String]? {
        switch self {
        case .people(let page):
            return ["page":"\(page)"]
        default :
            return nil
        }
    }
    
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        // Build our own array of url query item
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        #if DEBUG
        requestQueryItems.append(URLQueryItem(name: "delay", value: "2"))
        #endif
         
        
        urlComponents.queryItems = requestQueryItems
        return urlComponents.url
    }
}
