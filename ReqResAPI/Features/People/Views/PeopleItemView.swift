//
//  PeopleItemView.swift
//  ReqResAPI
//
//  Created by Manish Parihar on 30.10.23.
//

import SwiftUI

struct PeopleItemView: View {
    let user: User
    
    var body: some View {
        VStack(spacing:.zero){
            HStack {
                /*
                Rectangle()
                    .fill(.green)
                    .frame(width:80,height: 80)
                 */
                
                AsyncImage(url: .init(string: user.avatar)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:80,height: 80)
                        .clipped()
                        .presentationCornerRadius(10.0)
                        .shadow(radius: 10)
                } placeholder: {
                    ProgressView()
                }
                
                VStack (alignment: .leading){
                    RankingView(id:user.id)
                    
                    Text("\(user.firstName) \(user.lastName)")
                        .font(
                            .system(.caption, design: .rounded)
                            .bold()
                        )
                        .foregroundStyle(Theme.text)
                }            
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}

/*
#Preview {
     PeopleItemView()
}
*/

struct PeopleItemView_Previews: PreviewProvider {
    
    static var previewUser: User {
       let users = try! StaticJSONMapper.decode(file: "UsersStaticData",
                                            type: UsersResponse.self)
        return users.data.first!
    }
    
    static var previews: some View {
        PeopleItemView(user: previewUser)
            .frame(width: 250)
    }
}
