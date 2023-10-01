//
//  Service.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//


import Alamofire
import Combine

class BaseAPI<T: TargetType> : BaseService {
    
    func Request<M: Decodable>(target: T, responseClass: M.Type)   -> AnyPublisher<M , AFError>  {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = buildHeader(type: target.headers)
        let params = buildParams(task: target.task)
        printRequest(target: target)
        
        // build request
        let task = AF.request(target.baseURL + target.path, method: method , parameters: params.0, encoding: params.1 , headers: headers ) .validate().publishDecodable(type: M.self)
        
        return task .value()
            .receive(on: DispatchQueue.main)
            .compactMap { $0.self }
            .eraseToAnyPublisher()
        
    }
    /// build parmeters and encoding
    private func buildParams(task: RequestTask) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    /// build request  headers
    private func buildHeader(type : RequestHeader) -> HTTPHeaders {
        switch type {
        case .anonymous:
            return anonymousHeaders
        case .authorized:
            return authorizedHeaders
        }
    }
    
    /// print request
    private func printRequest(target: T) {
        print("------Start------")
        print("request called: \(target.baseURL)\(target.path)")
        print("http method: \(target.method)")
        print("headers: \(target.headers)")
        print("parameters: \(target.task)")
        print("------End------")
    }
}

