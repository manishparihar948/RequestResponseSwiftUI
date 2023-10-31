//
//  PeopleViewModel.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 31.10.23.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    
    
    func fetchUsers() {
        NetworkingManager.shared.request("https://reqres.in/api/users", type: UsersResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
