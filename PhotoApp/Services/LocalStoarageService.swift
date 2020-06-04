//
//  LocalStoarageService.swift
//  PhotoApp
//
//  Created by Jon Miller on 6/1/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation

class LocalStorageService {
    
    static func saveUser(userId: String?, username: String?) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(userId, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(username, forKey: Constants.LocalStorage.usernameKey)
    }
    
    
    static func loadUser() -> PhotoUser? {
        
        let defaults = UserDefaults.standard

        let userId      = defaults.value(forKey: Constants.LocalStorage.userIdKey) as? String
        let username    = defaults.value(forKey: Constants.LocalStorage.usernameKey) as? String
        
        if userId != nil && username != nil {
            
            return PhotoUser(userId: userId, username: username)
        }
        else { return nil }
    }
    
    
    static func clearUser() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: Constants.LocalStorage.userIdKey)
        defaults.set(nil, forKey: Constants.LocalStorage.usernameKey )
    }
}
