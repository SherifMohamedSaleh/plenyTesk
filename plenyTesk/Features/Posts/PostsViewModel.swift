//
//  PostsViewModel.swift
//  posts
//
//  Created by Sherif Abd El-Moniem on 19/09/2023.
//

import Alamofire
import Combine
import SwiftUI
import CoreData
import Foundation
import Network


class PostsViewModel: ObservableObject {
    
    let monitor = NWPathMonitor()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private var cancellables = Set<AnyCancellable>()
    private let persistentContainer: NSPersistentContainer
    
    private var service = PostsServices()
    
//    @Published var state : LoadingState = .idle

    
    @Published var posts: [PostModel] = []
    @Published var isLoading = false
    @Published var skip = 0
    @Published var limit = 10
    @Published var id = 0
    @Published var isRemainig = true
    @Published var searchText  = ""
    
    @Published var error: AFError?
    
    init() {
        persistentContainer = NSPersistentContainer(name: "PostsDataModel") // Replace with your Core Data model name
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading Core Data stores: \(error)")
            }
        }
        self.getUserData()
        Task { @MainActor [weak self] in  await self?.fetchMovies()}
    }
    
    func filterPosts() -> [PostModel] {
        //
        //        for  post in self.posts{
        //            if post.user == nil {
        //                getUser(id: post.userID , PostId: post.id)
        //            }
        //        }
        
        if searchText.isEmpty {
            return posts
        } else {
            return posts.filter { post in
                return post.title.localizedCaseInsensitiveContains(searchText) || post.body.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func getUserData(){
        if  let localId = UserDefaults.standard.object(forKey: "id") as? Int {
            id = localId
        }
        
    }
    
    //
    func getPostUser(id : Int , PostId : Int) {
        
        
        
        //                Task { @MainActor [weak self] in
        //                    guard let self = self else { return }
        print("update server side")
        service.getUser(userRequest: id ).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Error: \(error)")
            }
        }, receiveValue: { response in
            let user = response
            print("---------user-----------")
            print(user.username)
            print("--------------------")
            
            
            
            for var post in self.posts{
                if( post.id == PostId ) {
                    
                    post.user = User(id: user.id, firstName: user.firstName, lastName: user.lastName, maidenName: user.maidenName, age: user.age, gender: user.gender, email: user.email, phone: user.phone, username: user.username, image: user.image)
                    
                    print("---------post-----------")
                    print(post.user?.username ?? "" as String)
                    print("--------------------")
                }
            }
             
        }
        ) .store(in: &cancellables)
        //                    }
        //
        //
        //        service.getUser(userRequest: id ).sink(receiveCompletion: { completion in
        //            switch completion {
        //            case .finished:
        //                break
        //            case .failure(let error):
        //                print("Error: \(error)")
        //            }
        //        }, receiveValue: { [weak self] response in
        //            let user = response
        //            return user
        ////            for var post in self!.posts{
        ////                if( post.id == PostId ) {
        ////
        ////                    post.user = User(id: user.id, firstName: user.firstName, lastName: user.lastName, maidenName: user.maidenName, age: user.age, gender: user.gender, email: user.email, phone: user.phone, username: user.username, image: user.image)
        ////                }
        ////            }
        //
        //        }
        //        ) .store(in: &cancellables)
        
        
        
        
    }
    //
    func fetchMovies() async {
        
//        state = .loading

        if isRemainig {
            
            guard !isLoading else { return } // Prevent multiple requests
            
            isLoading = true
            error = nil
            service.getPosts(postRequest: PostRequestModel(skip, limit , id))
            
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { [weak self] response in
                    
                    let  newPosts = response.posts
                    if  !newPosts.isEmpty {
                        newPosts.forEach { post in
                            Task { @MainActor [weak self] in
                                self?.getPostUser(id: post.userID, PostId: post.id)
                            }

                        }
                        self?.posts.append(contentsOf: newPosts)
                        self?.cachePostsToCoreData(newPosts)
                        
                        self?.skip = response.skip + 10
                        if ( self!.skip >= response.total ){
                            self?.isRemainig = false
                        }
                    } else {
                        self?.error = self?.error
                        
                    }
                    
                    
                    self?.isLoading = false

                }
                )
            
                .store(in: &cancellables)
        }
    }
    
    func checkInternetConnection()  {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // Internet connection is available, fetch data from the API
                Task { @MainActor [weak self] in await self?.fetchMovies() }
            } else {
                // No internet connection, fetch data from Core Data
                self.fetchPostsFromCoreData()
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    
    func fetchPostsFromCoreData() {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let coreDataPosts = try viewContext.fetch(fetchRequest)
            self.posts = coreDataPosts.map { PostModel(id: Int($0.id), title:  $0.title ?? "", body: $0.body ?? "", userID:  Int($0.userId), tags:  [], reactions:  Int($0.reactions)) }
        } catch {
            print("Error fetching posts from Core Data: \(error)")
        }
    }
    
    private func cachePostsToCoreData(_ posts: [PostModel]) {
        persistentContainer.performBackgroundTask { context in
            do {
                for post in posts {
                    _ = try Post.createOrUpdate(from: post, in: context)
                }
                try context.save()
            } catch {
                print("Error caching posts to Core Data: \(error)")
            }
        }
    }
    
}
