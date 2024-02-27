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
    
    public func users(with usernamePrefix: String, completion: @escaping([User]) -> Void) {
        let ref = database.collection("user")
        ref.getDocuments { snaphot, error in
            guard let users = snaphot?.documents.compactMap({User(with: $0.data()) }), error == nil else {
                completion([])
                return
            }
            let subset = users.filter {
                $0.username.lowercased().hasPrefix(usernamePrefix.lowercased())
            }
            completion(subset)
        }
    }
    
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
    public func explorePosts(completion: @escaping ([Post]) -> Void) {
        let ref = database.collection("user")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil else {
                completion([])
                return
            }

            let group = DispatchGroup()
            var aggregatePosts = [Post]()

            users.forEach { user in
                group.enter()

                let username = user.username
                let postsRef = self.database.collection("user/\(username)/posts")

                postsRef.getDocuments { snapshot, error in

                    defer {
                        group.leave()
                    }

                    guard let posts = snapshot?.documents.compactMap({ Post(with: $0.data()) }),
                          error == nil else {
                        return
                    }

                    aggregatePosts.append(contentsOf: posts)
                    
                }
            }

            group.notify(queue: .main) {
                completion(aggregatePosts)
            }
        }
    }
    /// Find user with username
    /// - Parameters:
    ///   - username: Source username
    ///   - completion: Result callback
    public func findUser(username: String, completion: @escaping (User?) -> Void) {
        let ref = database.collection("user")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil else {
                completion(nil)
                return
            }

            let user = users.first(where: { $0.username == username })
            completion(user)
        }
    }
    public func getNotifications(
        completion: @escaping ([IGNotification]) -> Void
    ) {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            completion([])
            return
        }
        
        let ref = database.collection("user").document(username).collection("notifications")
        
        ref.getDocuments { snapshot, error in
            
            guard let notifications = snapshot?.documents.compactMap({
                IGNotification(with: $0.data())
            }),error == nil else {
                
                completion([])
                return
            }
            completion(notifications)
            
        }
    }
    public func insertNotification(
        identifer: String,
        data: [String: Any],
        for username: String
    ) {
        let ref = database.collection("user")
            .document(username).collection("notifications").document(identifer)
      
        ref.setData(data)
    }
    
    // Get a post with id and username
    /// - Parameters:
    ///   - identifer: Query id
    ///   - username: Query username
    ///   - completion: Result callback
    public func getPost(
        with identifer: String,
        from username: String,
        completion: @escaping (Post?) -> Void
    ) {
        let ref = database.collection("user")
            .document(username)
            .collection("posts")
            .document(identifer)
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  error == nil else {
                completion(nil)
                return
            }
            
            completion(Post(with: data))
        }
    }
    /// Follow states that are supported
    enum RelationshipState {
        case follow
        case unfollow
    }

    /// Update relationship of follow for user
    /// - Parameters:
    ///   - state: State to update to
    ///   - targetUsername: Other user username
    ///   - completion: Result callback
    public func updateRelationship(
        state: RelationshipState,
        for targetUsername: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard let currentUsername = UserDefaults.standard.string(forKey: "username") else {
            completion(false)
            return
        }

        let currentFollowing = database.collection("user")
            .document(currentUsername)
            .collection("following")

        let targetUserFollowers = database.collection("user")
            .document(targetUsername)
            .collection("followers")

        switch state {
        case .unfollow:
            // Remove follower for currentUser following list
            currentFollowing.document(targetUsername).delete()
            // Remove currentUser from targetUser followers list
            targetUserFollowers.document(currentUsername).delete()

            completion(true)
        case .follow:
            // Add follower for requester following list
            currentFollowing.document(targetUsername).setData(["valid": "1"])
            // Add currentUser to targetUser followers list
            targetUserFollowers.document(currentUsername).setData(["valid": "1"])

            completion(true)
        }
    }
}

