//
//  UserModel.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 01/10/2023.
//

import Foundation
struct User :  Equatable, Codable  {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender, email, phone, username: String
    let image: String
}
