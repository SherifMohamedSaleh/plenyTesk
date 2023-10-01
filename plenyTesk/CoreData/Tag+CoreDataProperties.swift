//
//  Tag+CoreDataProperties.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 27/09/2023.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var tagToPost: Post?
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }

}

extension Tag : Identifiable {

}
