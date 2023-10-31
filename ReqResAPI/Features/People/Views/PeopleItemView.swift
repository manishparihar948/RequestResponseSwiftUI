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
        VStack(alignment:.leading){
            HStack {
                AsyncImage(url: .init(string: user.avatar)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:80,height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 16,
                                                    style: .continuous))
                        .shadow(color: Theme.text.opacity(0.1),
                                radius: 2,
                                x: 0,
                                y: 1)
                        .padding(.leading,5)
                } placeholder: {
                    ProgressView()
                }
                .frame(alignment:.leading)
                
                VStack (alignment: .leading){
                    RankingView(id:user.id)
                    
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundStyle(Theme.text)
                }
            }
        }
        .frame(maxWidth: .infinity,alignment:.leading)
        .frame(height: 100)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 16,
                                    style: .continuous))
        .padding()
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
