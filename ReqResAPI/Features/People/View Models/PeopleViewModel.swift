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
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    
    func fetchUsers() {
        isLoading = true
        
        NetworkingManager.shared.request(.people, type: UsersResponse.self) { [weak self] res in
           
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
