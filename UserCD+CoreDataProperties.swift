//
//  UserCD+CoreDataProperties.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: NSSet?
    @NSManaged public var friends: NSSet?
    
    public var tagsArrayCD: [TagCD] {
        let set = tags as? Set<TagCD> ?? []
        return set.sorted {
            $0.tagName! < $1.tagName!
        }
    }
    
    var tagsArray: [String] {
        var tags: [String] = []
        for tag in tagsArrayCD {
            tags.append(tag.tagName!)
        }
        return tags
    }
    
    var friendsArray: [Friend] {
        var friendList: [Friend] = []
        let set = friends as? Set<FriendCD> ?? []
        let setSorted = set.sorted {
            $0.name! < $1.name!
        }
        for friend in setSorted {
            friendList.append(Friend(id: friend.id!, name: friend.name ?? "Unknown"))
        }
        return friendList
    }

}

// MARK: Generated accessors for tags
extension UserCD {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagCD)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagCD)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension UserCD {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendCD)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendCD)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension UserCD : Identifiable {

}
