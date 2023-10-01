//
//  LoginTarget.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//


import Alamofire
enum LoginTarget {
    case Login(loginRequestModel : LoginRequestModel)

}

extension LoginTarget : TargetType {
    var baseURL: String {
        switch self {
        
        case .Login :
            return "https://dummyjson.com/auth/"
        }
    }
    
    var path: String {
        switch self {
        
        case .Login :
            return "login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        
        case .Login:
            return .post
        }
    }
    
    var task: RequestTask {
        switch self {
        
        case .Login(let loginRequestModel ):
            return .requestParameters(parameters: [
                "Content-Type": "application/json",
                "username": loginRequestModel.userName  ,//kminchelle
                "password": loginRequestModel.password  ,//0lelplR
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: RequestHeader {
        switch self {
        
        case .Login:
            return .anonymous
        }
    }
}
