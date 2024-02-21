//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import Foundation
import FirebaseFirestore

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public func posts(for username: String, completion: @escaping(Result<[Post], Error>) -> Void){
        let ref = database.collection("user").document(username).collection("posts")
        ref.getDocuments { snaphot, error in
            guard let posts = snaphot?.documents.compactMap({Post(with: $0.data()) }), error == nil else {
        
                return
            }
            completion(.success(posts))
        }
    }
    
    public func findUsers(with email:String, completion: @escaping(User?)->Void){
        
        let ref = database.collection("user")
        ref.getDocuments { snapshot, error in
            
            guard let users = snapshot?.documents.compactMap({User(with: $0.data()) }), error == nil else {
                completion(nil)
                return
            }
            let user = users.first(where: {$0.email == email})
            completion(user)
        }
    }
    public func createPost(newPost: Post,completion: @escaping (Bool)->Void){
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }
        let reference = database.document("user/\(username)/posts/\(newPost.id)")
        guard let data = newPost.asDictionary()else {
            completion(false)
            return
        }
        
        reference.setData(data) {error in
            completion(error==nil)
        }
    }
    
    public func createUser(newUser:User, completion: @escaping (Bool)->Void){
        //add databse new user in firebase evethin on subdocument
        let reference = database.document("user/\(newUser.username)")
        guard let data = newUser.asDictionary()else {
            completion(false)
            return
        }
        
        reference.setData(data) {error in
            completion(error==nil)
        }
    }
}

