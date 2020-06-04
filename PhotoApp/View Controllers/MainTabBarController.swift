//
//  MainTabBarController.swift
//  PhotoApp
//
//  Created by Jon Miller on 6/2/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 2 {
            
            let actionSheet =   UIAlertController(title: "Add a photo", message: "Select a source:", preferredStyle: .actionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let cameraButton = UIAlertAction(title: "Camera", style: .default) { (action) in
                    
                    self.showImagePickerController(mode: .camera)
                }
                actionSheet.addAction(cameraButton)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                    
                    self.showImagePickerController(mode: .photoLibrary)
                }
                actionSheet.addAction(libraryButton)
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelButton)
            
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func showImagePickerController(mode: UIImagePickerController.SourceType) {
        
        let imagePicker         = UIImagePickerController()
        imagePicker.sourceType  = mode
        imagePicker.delegate    = self
        present(imagePicker, animated: true, completion: nil)
    }
}

extension MainTabBarController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if let selectedImage = selectedImage {
            
            let cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC {
                
                cameraVC.savePhoto(image: selectedImage)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func goToFeed () {
        
        selectedIndex = 0
    }
}
