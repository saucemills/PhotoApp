//
//  UserService.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/26/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId:String, username:String, completion: @escaping (PhotoUser?) -> Void) {
        
        let profileData = ["username": username]
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).setData(profileData) { (error) in
            
            if error ==  nil {
                
                var u = PhotoUser()
                u.userId = userId
                u.username = username
                completion(u)
            }
            else {
                
                completion(nil)
            }
        }
    }
    
    
    static func retrieveProfile(userId: String, completion: @escaping (PhotoUser?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            
            if error != nil || snapshot == nil {
                
                return
            }
            
            if let profile = snapshot!.data() {
                
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                completion(u)
            }
            else {
                
                completion(nil)
            }
        }
        
    }
    
}
