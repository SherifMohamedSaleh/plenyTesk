//
//  ImageBox.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 01/10/2023.
//

import Foundation
import SwiftUI

struct Box {
    var id :Int
    let  image :String
}

struct BoxView : View {
    let box : Box
    
    var body : some View {
        VStack{
            Image("\(box.image)")
                .resizable()
                .cornerRadius(12)
                .frame(width  : 140 , height : 140)
        }
    }
}
