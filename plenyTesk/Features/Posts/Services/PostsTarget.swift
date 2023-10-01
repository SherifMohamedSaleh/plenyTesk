//
//  PostsTarget.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//


import Alamofire

enum PostsTarget {
    case getAllPosts(postRequest :PostRequestModel)
    case getPostsUser(userRequest :Int)

}


extension PostsTarget : TargetType {
    var baseURL: String {
        switch self {
        case .getAllPosts:
            return "https://dummyjson.com/"
            
            
        case .getPostsUser :
            return "https://dummyjson.com/"
  
        }
    }
    var path: String {
        switch self {
        case .getAllPosts ( let postRequest ):
            return "posts?limit=\(postRequest.limit)&skip=\(postRequest.skip)"
//            /user/\(postRequest.id)
            
            
            
        case .getPostsUser(let userRequest):
            return "users/\(userRequest)"
            
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getAllPosts:
            return .get
        case .getPostsUser :
            return .get
        }
    }
    var task: RequestTask {
        switch self {
        case .getAllPosts:
            return .requestPlain
        case .getPostsUser:
            return .requestPlain

        }
    }
    var headers: RequestHeader {
        switch self {
        case .getAllPosts:
            return .anonymous
            
        case .getPostsUser:
            return .anonymous

        }
    }
}
