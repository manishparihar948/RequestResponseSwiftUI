//
//  PeopleView.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 1)
    
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                ScrollView {
                    LazyVGrid(columns:columns, spacing: 5) {
                        ForEach(0...5, id: \.self) { item in
                          //  PeopleItemView(user: user)
                          Text("Hello: \(item)")
                        }
                    }
                    .padding()
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
