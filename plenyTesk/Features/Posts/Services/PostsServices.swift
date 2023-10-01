//
//  PostsServices.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//

import Foundation
import Alamofire
import Combine

class PostsServices :  BaseAPI<PostsTarget>  , ObservableObject {
    
    func getPosts(postRequest : PostRequestModel)  -> AnyPublisher<PostsResponse , AFError>  {
        return  self.Request(target: .getAllPosts( postRequest : postRequest) , responseClass:PostsResponse.self)
    }
    
    
    
    func getUser(userRequest : Int)  -> AnyPublisher<User , AFError>  {
        return  self.Request(target: .getPostsUser(userRequest: userRequest), responseClass:User.self)
    }
}
