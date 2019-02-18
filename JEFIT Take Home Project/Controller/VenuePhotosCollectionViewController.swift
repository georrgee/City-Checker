//
//  VenuePhotosCollectionViewController.swift
//  JEFIT Take Home Project
//
//  Created by George Garcia on 2/13/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import UIKit

// in VenuesTableViewController -> every cell is a venue, inside every cell, you are able to get photos of that venue
// in VenuePhotoCollectionViewController -> you have 1 seelcted venue -> you have to get all photos of that venue.

class VenuePhotosCollectionViewController: UICollectionViewController {
    
    var isPressed: Bool = false

    let cellID = "PhotosCollectionViewCell"
    
    // viewDidload
    // get all  photos from api
    // update datasource
    // reload collectionview
    
    var dataSource = [String]() // photo urls
    { didSet {
        collectionView.reloadData()
    }}
    
    var venueId: String?
    var bookmarkKey: String?
    var isBookmarked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
        setupBookmarkBarButton()
    }
    
    func getPhotos() {
        //guard let
        NetworkingService.shared.getCollectionPhotos(venueID: venueId!, success: { (urls) in
            self.dataSource = urls
        }) { (err) in
            
        }
    }
    
    static func create() -> VenuePhotosCollectionViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VenuePhotosCollectionViewController") as! VenuePhotosCollectionViewController
    }

    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotosCollectionViewCell
        cell.data = dataSource[indexPath.row]
        
        return cell
    }
    
    func setupBookmarkBarButton() {
        let bookmarkButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookmarkTapped))
        bookmarkButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = bookmarkButton
    }
    
    @objc func bookmarkTapped(){
        
        if !isBookmarked {
            let alert = UIAlertController(title: "Bookmarked!", message: "You have bookmarked this venue!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Sweet!", style: .default) { (action) in
                print("User Placed Bookmark")
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            if let bookmarkKey = bookmarkKey {
                UserDefaults.standard.set(true, forKey: bookmarkKey)
                print("About to set bookmark key", bookmarkKey)
                isBookmarked = true
            }
        
            
        } else {
            let alert = UIAlertController(title: "Bookmark Removed!", message: "You have remove the bookmark for this venue!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Thank you!", style: .default) { (action) in
                print("User Removed Bookmark")
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            if let bookmarkKey = bookmarkKey {
                UserDefaults.standard.set(false, forKey: bookmarkKey)
                print("About to set bookmark key", bookmarkKey)
                isBookmarked = false
            }
        }
        
    }
    
}
