//
//  BaseResponse.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//

import Foundation

struct BaseResponse<T : Decodable> : Decodable {
    let data: T
}
