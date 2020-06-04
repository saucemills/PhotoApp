//
//  Photo.swift
//  PhotoApp
//
//  Created by Jon Miller on 6/2/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Photo {
    
    var photoId:String?
    var byId:String?
    var username:String?
    var date:String?
    var url:String?
    
    init? (snapshot: QueryDocumentSnapshot) {
        
        let data        = snapshot.data()
        
        let photoId     = data["photoId"] as? String
        let userId      = data["byId"] as? String
        let username    = data["byUsername"] as? String
        let date        = data["date"] as? String
        let url         = data["url"] as? String
        
        if photoId == nil || userId == nil || username == nil || date == nil || url == nil {
            
            return nil
        }
        
        self.photoId    = photoId
        self.username   = username
        self.byId       = userId
        self.date       = date
        self.url        = url
    }
}
