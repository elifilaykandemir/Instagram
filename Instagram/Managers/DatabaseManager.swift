//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 2.02.2023.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
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

