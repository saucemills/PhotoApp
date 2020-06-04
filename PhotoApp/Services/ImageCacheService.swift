//
//  ImageCacheService.swift
//  PhotoApp
//
//  Created by Jon Miller on 6/4/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheService {
    
    static var imageCache = [String:UIImage]()
    
    static func saveImage(url:String?, image:UIImage?) {
        
        if url == nil || image == nil {
            
            return
        }
        
        imageCache[url!] = image!
    }
    
    
    static func getImage(url:String?) -> UIImage? {
        
        if url == nil {
            
            return nil
        }
        
        return imageCache[url!]
    }
}
