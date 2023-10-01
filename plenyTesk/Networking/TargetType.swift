//
//  TargetType.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//


import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum RequestTask {

    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

enum RequestHeader  {
    
    ///  BaseService().anonymousHeaders
    case anonymous
    
    ///  BaseService().authorizedHeaders
    case authorized

}

protocol TargetType  {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: RequestTask { get }
    
    /// The headers to be used in the request.
    var headers: RequestHeader { get }
    
}
