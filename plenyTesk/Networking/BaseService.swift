//
//  BaseService.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//

import Foundation
import Alamofire


class BaseService {
    
   private var token =   ""
  
    var anonymousHeaders: HTTPHeaders {
        return [ "Accept-Language" : "en" ]
    }
    
    
  var authorizedHeaders: HTTPHeaders {
    get{
      let sharedHeaders : HTTPHeaders =  [
                "Accept-Language" : "en" ,
                "Authorization" : "Bearer " + token
        ]
      return sharedHeaders
    }
  }
}
