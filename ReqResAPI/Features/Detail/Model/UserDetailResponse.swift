//
//  UserDetailResponse.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import Foundation

struct UserDetailResponse: Codable {
    
    let data : User
    let support: Support
}
