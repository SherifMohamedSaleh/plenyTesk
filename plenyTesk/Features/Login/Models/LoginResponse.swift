//
//  LoginResponse.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//

import Foundation

struct LogInResponseModel : Decodable {
    var id : Int?
    var username : String?
    
    var email : String?
    var firstName : String?
    var lastName : String?
    var gender : String?
    var image : String?
    var token : String?


    

}
