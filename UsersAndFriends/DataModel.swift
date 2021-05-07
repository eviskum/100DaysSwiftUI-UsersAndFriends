//
//  DataModel.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//

import Foundation

struct User: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable {
    var id: UUID
    var name: String
}

struct Tag: Codable {
    var tag: String
}

class Users: ObservableObject {

    @Published var users: [User]
    
    init() {
        users = []
    }

}
