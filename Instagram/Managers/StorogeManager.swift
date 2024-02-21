//
//  StorogeManager.swift
//  Instagram
//
// Created by Elif İlay Eser
//

import Foundation
import FirebaseStorage


final class StorageManager{
    
    static let shared = StorageManager()
    
    private init() {}
    
    let storage = Storage.storage().reference()
    
    public func uploadProfilePicture(
        username:String,
        data:Data?,
        completion:@escaping(Bool)->Void){
            
        guard let data = data else {return}
            
        storage.child("\(username)/profile_picture.png").putData(data,metadata:nil) { _,error in
            completion(error==nil)
        }
    }
    
    public func downloadURL(for post: Post, completion: @escaping (URL?) -> Void) {
        guard let ref = post.storageReference else {
            completion(nil)
            return
        }
        
        storage.child(ref).downloadURL { url, _ in
            completion(url)
        }
    }
    public func profilePictureURL(for username: String, completion: @escaping (URL?) -> Void) {
        storage.child("\(username)/profile_picture.png").downloadURL { url, _ in
            completion(url)
        }
    }
    
    public func uploadPost(
        data:Data?,
        id: String,
        completion:@escaping(URL?)->Void){
            
            guard let username = UserDefaults.standard.string(forKey: "username"),let data = data else {
                return
            }
            let ref = storage.child("\(username)/posts/\(id).png")
            ref.putData(data, metadata: nil) { _, error in
                ref.downloadURL { url, _ in
                    completion(url)
                }
            }
    }
}
