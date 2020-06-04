//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/26/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        progressBar.alpha       = 0
        progressBar.progress    = 0
        
        doneButton.alpha        = 0
        
        progressLabel.alpha     = 0
    }
    
    
    func savePhoto(image: UIImage) {
        
        PhotoService.savePhoto(image: image) { (pct) in
            
            DispatchQueue.main.async {
                
                self.progressBar.alpha      = 1
                self.progressBar.progress   = Float(pct)
                
                let roundedPct              = Int(pct * 100)
                self.progressLabel.text     = "\(roundedPct) %"
                self.progressLabel.alpha    = 1
                
                if roundedPct == 100 {
                    
                    self.progressLabel.text = "Upload completed!"
                    self.doneButton.alpha   = 1
                }
            }
        }
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        
        let tabBarVC = self.tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            tabBarVC.goToFeed()
        }
    }
}
