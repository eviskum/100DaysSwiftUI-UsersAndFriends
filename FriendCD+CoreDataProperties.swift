//
//  FriendCD+CoreDataProperties.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//
//

import Foundation
import CoreData


extension FriendCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCD> {
        return NSFetchRequest<FriendCD>(entityName: "FriendCD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: UserCD?

}

extension FriendCD : Identifiable {

}
