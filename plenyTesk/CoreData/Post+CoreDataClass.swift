//
//  Post+CoreDataClass.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 27/09/2023.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject  {
    
    
    
    static func createOrUpdate(from post: PostModel, in context: NSManagedObjectContext) throws -> Post {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", post.id)
        
        if let existingPost = try context.fetch(request).first {
            existingPost.update(from: post)
            return existingPost
        } else {
            let newPost = Post(context: context)
            newPost.update(from: post)
            return newPost
        }
    }
    
    
    func update(from post: PostModel) {
        self.id = Int16(post.id)
        self.title = post.title
        self.body = post.body
        self.userId = Int16(post.userID)
        self.reactions = Int16(post.reactions)
    }
    
    
    
}
