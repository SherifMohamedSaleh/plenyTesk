////
////  RealmService.swift
////  posts
////
////  Created by Sherif Abd El-Moniem on 19/09/2023.
////
//
//
//
//import Foundation
//import RealmSwift
//import Combine
//import Alamofire
//
//class RealmService {
//    static let shared = RealmService()
//    private var realm: Realm
//
//    private init() {
//        do {
//            realm = try Realm()
//        } catch {
//            fatalError("Error initializing Realm: \(error)")
//        }
//    }
//
//    func saveProducts(_ products: PostsResponse) {
//        do {
//            try realm.write {
//                realm.add(products, update: .modified)
//            }
//        } catch {
//            print("Error saving products: \(error)")
//        }
//    }
//
//
//
//
//    func retrieveProduct() -> AnyPublisher<PostsResponse, Error>{
//
//            let tasks = realm.objects(PostsResponse.self)
//        return tasks.publisher
//                   .eraseToAnyPublisher()
//    }
//
//
//}
//
