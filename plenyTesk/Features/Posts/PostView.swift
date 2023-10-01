//
//  PostView.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 23/09/2023.
//

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


@MainActor
struct PostsListView: View {
    
    
    let boxes :[Box] = [
    Box(id: 0, image: "login"),
    Box(id: 1, image: "1"),
    Box(id: 2, image: "2"),
    Box(id: 3, image: "3")

    ]
    
    @EnvironmentObject private var coordinator: Coordinator
    
    @ObservedObject var viewModel: PostsViewModel
    @State var searchText = ""


    var body: some View {
            
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding()
                List(viewModel.filterPosts(), id: \.id) { post in
                    Button(action: {
                        
                        self.coordinator.push(.postDetails(id: post.id ))
                        
                    }) {
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            ScrollView{
                                
                                ForEach(0..<2) { i in
                                    HStack {
                                        ForEach(0..<2) { j in
                                            BoxView(box: boxes[i+j])
                                            
                                        }
                                    }
                                }
                            }
                            
                        }
                        .onAppear{
                            if post == viewModel.posts.last  && viewModel.isRemainig{
                                Task {   await self.viewModel.fetchMovies()}
                                
                            }
                        }
                    }
                    .searchable(text: $searchText)
                    
                }
                .onAppear {
                    viewModel.checkInternetConnection()
                    }
            }.navigationBarHidden(true)
    }

    struct SearchBar: View {
        @Binding var text: String

        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }

}


struct PostsDetailView: View {
//    @ObservedObject var viewModel: PostsViewModel = 
    var id :Int?
//    var name : String?
    init( id: Int ) {
        self.id = id
//        self.name = name
    }
    var body: some View {
        VStack{
            Text("MovieDetailView")

            Text("id \(id!) ")
        }

    }
}
