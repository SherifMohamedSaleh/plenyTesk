//
//  LoginRequest.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//

import Foundation
import SwiftUI

class LoginRequestModel : ObservableObject  {
    init(_ userName: String , _ password : String) {
        
        self.userName = userName
        self.password = password
    }
    var userName : String
    var password  : String
}
