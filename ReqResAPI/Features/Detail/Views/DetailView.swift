//
//  DetailView.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import SwiftUI

struct DetailView: View {
    
    @State private var userInfo : UserDetailResponse?
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroud
                
                ScrollView {
                    VStack(alignment:.leading, spacing: 10) {
                        avatar
                        Divider()

                        Group {
                            RankingView(id: userInfo?.data.id ?? 0)
                            general
                            Divider()
                            support
                        }
                        .padding(.horizontal,8)
                        .padding(.vertical, 10)
                        .background(Theme.detailBackground,
                                    in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }
            }
            .navigationTitle("User Details")
            .onAppear {
                do {
                     userInfo = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
                    
                } catch {
                    print(error)
                }
            }
        }
    }
}


#Preview {
    NavigationStack{
        DetailView()
    }
}


private extension DetailView {
    
    var backgroud : some View {
        Theme.detailBackground
            .ignoresSafeArea(.all)
    }
}

private extension DetailView {
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = userInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            AsyncImage(url:avatarUrl) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height:250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var general : some View {
        // Text
        Text("First Name: \(userInfo?.data.firstName ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)

        Text("Last Name: \(userInfo?.data.lastName ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)
        
        Text("Email: \(userInfo?.data.email ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)

    }
    
    @ViewBuilder
    var support: some View {
        // Text - Support
        Text(userInfo?.support.text ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)
        
        Text("URL : \(userInfo?.support.url ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.thin)
            )
            .foregroundStyle(Theme.text)
    }
}
