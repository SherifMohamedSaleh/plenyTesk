//
//  Extentions.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//

import UIKit
 
func resignKeyboard() {
    UIApplication.shared.endEditing()
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
