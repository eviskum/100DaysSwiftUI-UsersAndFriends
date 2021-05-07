//
//  UserDetails.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//

import SwiftUI

struct UserDetails: View {
    var user: User
    var friends: [User]
    @ObservedObject var userList: Users
    
    var body: some View {
        ScrollView {
            VStack() {
                Text("Is active: \(user.isActive ? "YES" : "NO")")
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text(user.about)
                    .padding()
                    .layoutPriority(1)
                
                ForEach(friends, id: \.id) { friend in
                    NavigationLink(destination: UserDetails(user: friend, userList: userList)) {
                        Text(friend.name)
                    }
                }
                
            }
        }
        .navigationBarTitle(user.name)
    }
    
    init(user: User, userList: Users) {
        self.user = user
        friends = []
        self.userList = userList
        
        for selectedUser in userList.users {
            if user.friends.first(where: { $0.id == selectedUser.id }) != nil {
                friends.append(selectedUser)
            }
        }
    }
}
