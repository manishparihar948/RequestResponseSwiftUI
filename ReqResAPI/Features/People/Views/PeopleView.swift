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
    @State private var hasAppeared = false
    
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
                        Task {
                            await vm.fetchUsers()
                        }
                    } label: {
                        Symbols.refresh
                            .font(
                                .system(.headline, design: .rounded)
                                .bold()
                            )
                    }
                    .disabled(vm.isLoading)
                }
            }
            .task{
                if !hasAppeared {
                    await vm.fetchUsers()
                    hasAppeared = true
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry"){
                    Task {
                        await vm.fetchUsers()
                    }
                }
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
