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
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private var page = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    @MainActor
    func fetchUsers() async {
        
        reset()
        
        viewState = .loading
        defer { viewState = .finished }
        
        do {
            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self)
            self.users = response.data
            self.totalPages = response.totalPages
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    
    @MainActor
    func fetchNextSetOfUsers() async {
        guard page != totalPages else { return }
        
        page += 1
        
        viewState = .fetching
        defer { viewState = .finished }
        
        do {
            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self)
            self.users += response.data
            self.totalPages = response.totalPages

        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // Purpose - if the user reached end of the current array
    func hasReachedEnd(of user:User) -> Bool {
        users.last?.id == user.id
    }
}

extension PeopleViewModel {
    enum ViewState  {
        case fetching
        case loading
        case finished
    }
}

// private function

private extension PeopleViewModel {
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
