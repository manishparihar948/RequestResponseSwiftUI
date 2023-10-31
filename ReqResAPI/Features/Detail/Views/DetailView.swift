//
//  DetailView.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import SwiftUI

struct DetailView: View {
    
    let userId: Int
    @StateObject private var vm = DetailViewModel()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroud
                
                ScrollView {
                    VStack(alignment:.leading, spacing: 10) {
                        avatar
                        Divider()

                        Group {
                            RankingView(id: vm.userInfo?.data.id ?? 0)
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
                vm.fetchDetails(for: userId)
            }
        }
    }
}


/*
#Preview {
    NavigationStack{
        DetailView(userId: <#Int#>)
    }
}
*/

struct DetailView_Previews: PreviewProvider {
    private static var previewUserId: Int {
        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        return users.data.first!.id
    }
    
    static var previews: some View {
         NavigationStack {
            DetailView(userId: previewUserId)
         }
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
        if let avatarAbsoluteString = vm.userInfo?.data.avatar,
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
        Text("First Name: \(vm.userInfo?.data.firstName ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)

        Text("Last Name: \(vm.userInfo?.data.lastName ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)
        
        Text("Email: \(vm.userInfo?.data.email ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)

    }
    
    @ViewBuilder
    var support: some View {
        // Text - Support
        Text(vm.userInfo?.support.text ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
            .foregroundStyle(Theme.text)
        
        Text("URL : \(vm.userInfo?.support.url ?? "-")")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.thin)
            )
            .foregroundStyle(Theme.text)
    }
}
