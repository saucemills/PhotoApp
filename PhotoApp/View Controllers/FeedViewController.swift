//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Jon Miller on 5/26/20.
//  Copyright © 2020 Jon Miller. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addRefreshControl()

        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            self.photos = retrievedPhotos
            self.tableView.reloadData()
        }
    }
    
    func addRefreshControl() {
        
        let refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        self.tableView.addSubview(refresh)
    }
    
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        
        PhotoService.retrievePhotos { (newPhotos) in
            
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
                refreshControl.endRefreshing()
            }
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = self.photos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        cell.displayPhoto(photo: photo)
        
        return cell
    }
    
    
    
}
