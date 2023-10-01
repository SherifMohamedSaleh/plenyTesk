//
//  Post+CoreDataProperties.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 27/09/2023.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: Int16
    @NSManaged public var userId: Int16
    @NSManaged public var reactions: Int16
    @NSManaged public var body: String?

    @NSManaged public var title: String?
    @NSManaged public var postToTag: NSSet?
    
    
    public var wrappedody: String {
        body ?? "Unknown body"
    }
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }

    public var tags: [Tag] {
         let set = postToTag as? Set<Tag> ?? []
         return set.sorted {
             $0.wrappedName < $1.wrappedName
         }
     }
}

// MARK: Generated accessors for postToTag
extension Post {

    @objc(addPostToTagObject:)
    @NSManaged public func addToPostToTag(_ value: Tag)

    @objc(removePostToTagObject:)
    @NSManaged public func removeFromPostToTag(_ value: Tag)

    @objc(addPostToTag:)
    @NSManaged public func addToPostToTag(_ values: NSSet)

    @objc(removePostToTag:)
    @NSManaged public func removeFromPostToTag(_ values: NSSet)

}

