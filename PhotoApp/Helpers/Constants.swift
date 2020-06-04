//
//  Constants.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/26/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Storyboard {
        
        static let tabBarController     = "mainTabBarController"
        static let profileSegue         = "goToCreateProfile"
        static let loginNavController   = "loginNavController"
        }
    
    struct LocalStorage {
        
        static let userIdKey            = "storedUserId"
        static let usernameKey          = "storedUsername"
    }
}
