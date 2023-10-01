//
//  networkEnums.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//


import Alamofire


// TODO: - update error with server error

enum NetworkError: Error {
    case error
    case customError(error :AFError )
    case errorCode(withCode : ServerStatusCodes)
    case customErrorWithCode(errrMessage: AFError ,withCode : ServerStatusCodes)
}

enum ServerStatusCodes : Int {
    case InvalidURl = 404
    case Successed = 200
    case SessionExpired = 401
    case ValidationError = 400
    case ServerError  = 500
}

struct ErrorMessage {
    static let genericErrorMessage = "Couldn't submit your request. Please try again later."
    static let noStatusError = "No status code something went wrong"
    static let noResponseError = "No response"
    static let decodeError = "failed to decode object"
    static let validationError = "Invalid Data"
    static let authValidationError = "Invalid username or password!"
    static let networkError = "Network Error \nPlease check your internet connection and try again  "
}

