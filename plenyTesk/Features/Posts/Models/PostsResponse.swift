//
//  PostsResponse.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//

import Foundation
import Combine
import Alamofire
import ObjectMapper

// MARK: - PostsResponse
struct PostsResponse :  Equatable, Codable   {
    var posts: [PostModel]
    let total, skip, limit: Int
}

// MARK: - PostModel
struct PostModel: Equatable ,Codable  {
    
    let id: Int
    let title, body: String
    let userID: Int
    let tags: [String]
    let reactions: Int
    var user: User?

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case userID = "userId"
        case tags, reactions
    }
}
