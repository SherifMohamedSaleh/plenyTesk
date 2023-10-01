//
//  Coordinator.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 25/09/2023.
//

import Foundation

import SwiftUI

enum Page : Hashable{
    case login
     case postList
    case postDetails (id : Int)
    
    
//    var id: String {
//        self.rawValue
//    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @State var isLogin : Bool = false ;

    
    func push(_ page: Page) {
        path.append(page)
    }
 
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
   
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .login:
            LoginView()
        case .postList:
            let postsViewModel = PostsViewModel()
            PostsListView(viewModel: postsViewModel)
        case .postDetails(let id):
            PostsDetailView(id: id)

        }
    }
}
