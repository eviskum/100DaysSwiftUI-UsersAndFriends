//
//  UsersAndFriendsApp.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//

import SwiftUI

@main
struct UsersAndFriendsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
