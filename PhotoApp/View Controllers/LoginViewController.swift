//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/24/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        if let authUI = authUI {
            
            authUI.delegate = self
            
            authUI.providers = [FUIEmailAuth()]
            
            let authViewController = authUI.authViewController()
            
            present(authViewController, animated: true, completion: nil)
        }
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil {
            // There was an error
            return
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            
            // Got a user
            // Check on the database side if user has a profile
            UserService.retrieveProfile(userId: user.uid) { (user) in
                
                // Check if user is nil
                if user == nil {
                    // If not, go to create profile view controller
                    self.performSegue(withIdentifier: Constants.Storyboard.profileSegue, sender: self)
                }
                else {
                    // If so, go to tab bar controller
                    
                    LocalStorageService.saveUser(userId: user!.userId, username: user!.username)
                    // Create an instance of the tab bar controller
                    let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    
                    guard tabBarVC != nil else {
                        return
                    }
                    
                    // Set it as the root view controller of the window
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                }
            }
            
            
            
        }
        
    }
    
}

