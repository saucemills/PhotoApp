//
//  SettingsViewController.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/26/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        do {
            
            try Auth.auth().signOut()
            
            LocalStorageService.clearUser()
            
            let loginNavVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavController)
            
            self.view.window?.rootViewController = loginNavVC
            self.view.window?.makeKeyAndVisible()
            
        }
        catch {
            
        }
    }
}
