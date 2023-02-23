//
//  StorogeManager.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 2.02.2023.
//

import Foundation
import FirebaseStorage


final class StorageManager{
    
    static let shared = StorageManager()
    
    private init() {}
    
    let database = Storage.storage()
    
}
