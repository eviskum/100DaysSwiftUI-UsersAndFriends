//
//  TagCD+CoreDataProperties.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//
//

import Foundation
import CoreData


extension TagCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagCD> {
        return NSFetchRequest<TagCD>(entityName: "TagCD")
    }

    @NSManaged public var tagName: String?
    @NSManaged public var user: UserCD?

}

extension TagCD : Identifiable {

}
