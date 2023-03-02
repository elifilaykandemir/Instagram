//
//  AuthManager.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 2.02.2023.
//

import Foundation
import FirebaseAuth

final class AuthManager{
    
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    enum AuthError:Error {
        case newUserCreation
        case signInFailed
    }
    
    public var isSignedIn:Bool{
        return auth.currentUser != nil
    }
    
    public func signIn(email:String,
                       password: String,
                       completion: @escaping (Result<User,Error>)->Void){
        
        //if you query added data base whan we have successfuly sign in we need query database
        DatabaseManager.shared.findUsers(with: email) { [weak self] user in
            guard let user = user else{
                completion(.failure(AuthError.signInFailed))
                return
            }
            self?.auth.signIn(withEmail: email, password: password){ result, error in
                guard result != nil , error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                    
                }
                
                
                UserDefaults.standard.setValue(user.username, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                completion(.success(user))
            }
            
        }
    }
        
    
    // Create Account when the user sign up firabase authantication is work
    public func signUp(email:String,
                       username:String,
                       password: String,
                       profilePicture:Data?,
                       completion: @escaping (Result<User,Error>)->Void){
        
        let newUser = User(username: username, email: email)
        auth.createUser(withEmail: email, password: password){ result,error in
            
            guard result != nil, error == nil else {return}
            completion(.failure(AuthError.newUserCreation))
            
            // we want to insert new user to the database we have seperate manager for database
            
            DatabaseManager.shared.createUser(newUser: newUser){success in
                if success{
                    StorageManager.shared.uploadProfilePicture(
                        username: username,
                        data: profilePicture
                    ) {uploadSuccess in
                        if uploadSuccess{
                            completion(.success(newUser))
                        }
                        else {
                            completion(.failure(AuthError.newUserCreation))
                            
                        }
                    }
                }
                else{
                    
                    completion(.failure(AuthError.newUserCreation))
                }
            }
        }
}
    
    public func signOut(
        completion: @escaping (Bool)->Void){
            do {
                try auth.signOut()
                completion(true)
            }
            catch {
                print(error)
                completion(false)
            }
    }
}


