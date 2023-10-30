//
//  UsersResponse.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import Foundation

struct UsersResponse: Codable {
    
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}

