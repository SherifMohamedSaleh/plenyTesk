//
//  ViewExtension.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 18/09/2023.
//

import Foundation

import SwiftUI
extension View {
    func vCenter()->some View {
        self.frame(maxHeight : .infinity , alignment : .center)
    }
    func vTop()->some View {
        self.frame(maxHeight : .infinity , alignment : .top)
    }
    func vBottom()->some View {
        self.frame(maxHeight : .infinity , alignment : .bottom)
    }
    func hCenter()->some View {
        self.frame(maxWidth : .infinity , alignment : .center)
    }
    func hLeading()->some View {
        self.frame(maxWidth : .infinity , alignment : .leading)
    }
    func hTrailing()->some View {
        self.frame(maxWidth : .infinity , alignment : .trailing)
    }
}
