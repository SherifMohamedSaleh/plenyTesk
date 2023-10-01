//
//  LoginService.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//


import Foundation
import Alamofire
import Combine

class LoginService  :  BaseAPI<LoginTarget>  , ObservableObject {
    
    func loginUser(loginRequestModel : LoginRequestModel)  -> AnyPublisher<LogInResponseModel , AFError> {

        return self.Request(target: .Login(loginRequestModel : loginRequestModel) , responseClass: LogInResponseModel.self)
    }
    
}
