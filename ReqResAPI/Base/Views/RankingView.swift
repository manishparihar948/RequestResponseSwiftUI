//
//  RankingView.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import SwiftUI

struct RankingView: View {
    let id: Int
    var body: some View {
      Text("#\(id)")
            .font(
                .system(.caption, design: .rounded)
                .bold()
            )
            .foregroundStyle(.text)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.star, in:Capsule())

    }
}

#Preview {
    RankingView(id:0)
        .padding()
        .previewLayout(.sizeThatFits)
}
