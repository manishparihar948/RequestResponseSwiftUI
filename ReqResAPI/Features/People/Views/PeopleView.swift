//
//  PeopleView.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 1)
    
    @StateObject private var vm = PeopleViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                ScrollView {
                    LazyVGrid(columns:columns, spacing: .zero) {
                        ForEach(vm.users, id: \.id) { user in
                            NavigationLink{
                                DetailView(userId: user.id)
                            } label: {
                                PeopleItemView(user: user)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Request-User")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Symbols.refresh
                            .font(
                                .system(.headline, design: .rounded)
                                .bold()
                            )
                    }
                }
            }
            .onAppear{
                vm.fetchUsers()
            }
        }
    }
}

#Preview {
    PeopleView()
}

private extension PeopleView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .all)
    }
}
