//
//  PostRequest.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 19/09/2023.
//

import Foundation
import SwiftUI

class PostRequestModel : ObservableObject  {
    init(_ skip: Int , _ limit : Int ,  _ id : Int)  {
        
        self.skip = skip
        self.limit = limit
        self.id = id

    }
    var skip : Int
    var limit  : Int
    var id  : Int

}
