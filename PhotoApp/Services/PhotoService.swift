//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Jon Miller on 6/2/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoService {
    
    static func retrievePhotos(completion: @escaping ([Photo]) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("photos").getDocuments { (snapshot, error) in
            
            if error != nil {
                
                return
            }
            
            let documents = snapshot?.documents
            
            if let documents = documents {
                
                var photoArray = [Photo]()
                
                for doc in documents {
                    
                    let p = Photo(snapshot: doc)
                    
                    if p != nil {
                        
                        photoArray.insert(p!, at: 0)
                    }
                }
                
                completion(photoArray)
            }
        }
    }
    
    static func savePhoto(image:UIImage, progressUpdate: @escaping (Double) -> Void ) {
        
        if Auth.auth().currentUser == nil { return }
        
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else { return }
        
        let filename = UUID().uuidString
        
        let userId = Auth.auth().currentUser!.uid
        
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpeg")
        
        let uploadTask = ref.putData(photoData!, metadata: nil) { (metadata, error) in
            
            if error == nil {
                
                self.createDatabaseEntry(ref: ref)
            }
        }
        
        uploadTask.observe(.progress) { (taskSnapshot) in
            
            let pct = Double(taskSnapshot.progress!.completedUnitCount) / Double(taskSnapshot.progress!.totalUnitCount)
            
            print(pct)
            
            progressUpdate(pct)
        }
        
    }
    
    private static func createDatabaseEntry(ref: StorageReference) {
        
        ref.downloadURL { (url, error) in
            
            if error == nil {
                
                let photoId = ref.fullPath
                
                let photoUser = LocalStorageService.loadUser()
                
                let userId = photoUser?.userId
                
                let username = photoUser?.username
                
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                let metadata = ["photoId": photoId,
                                "byId": userId!,
                                "byUsername": username!,
                                "date": dateString,
                                "url": url?.absoluteString]
                
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata as [String : Any]) { (error) in
                    
                    if error == nil {
                        // entry created successfully
                    }
                }
            }
        }
    }
}
