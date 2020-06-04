//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Jon Miller on 6/3/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo: Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func displayPhoto(photo: Photo) {
        
        self.photoImageView.image = nil
        
        self.photo = photo
        
        usernameLabel.text = photo.username
        
        dateLabel.text = photo.date
        
        if photo.url == nil { return }
        
        if let cachedImage = ImageCacheService.getImage(url: photo.url!) {
            
            self.photoImageView.image = cachedImage
            
            return
        }
        
        let url = URL(string: photo.url!)
        
        if url == nil { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)
                
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                if url!.absoluteString != self.photo?.url! {
                    
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.photoImageView.image = image
                }
            }
        }
        dataTask.resume()
    }

}
