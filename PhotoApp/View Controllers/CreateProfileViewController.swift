//
//  CreateProfileViewController.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/24/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        
        guard Auth.auth().currentUser != nil else {
            
            return
        }
        
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if username == nil || username == "" {
            
            return
        }
        
        UserService.createProfile(userId: Auth.auth().currentUser!.uid, username: username!) { (user) in
            
            if user != nil {
                
                LocalStorageService.saveUser(userId: user?.userId, username: user?.username)
                
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
            
            else {
                return
            }
        }
    }
}
