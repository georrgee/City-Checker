//  VenuePhotosCollectionViewController.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/13/19.
//  Copyright © 2019 George Garcia. All rights reserved

// Description: Here we can show a grid like collection of the Venue's Photos (when user selects a venue, show the collection of photos for that Venue)

import UIKit

class VenuePhotosCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    var isPressed: Bool = false
    let cellID          = "PhotosCollectionViewCell"
    var isBookmarked    = false
    var venueId:        String?
    var bookmarkKey:    String?
    
    var dataSource = [String]() {
        didSet { collectionView.reloadData() } }
    
    // MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getVenueCollectionPhotosData()
        setupBookmarkBarButton()
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotosCollectionViewCell
        cell.data = dataSource[indexPath.row]
        
        return cell
    }
    
    // MARK: NavigationBar - Button, Button Action
    private func setupBookmarkBarButton() { // creating a navigation bar button (located on the right side) with its customization
        
        let bookmarkButton       = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookmarkTapped))
        bookmarkButton.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = bookmarkButton
    }
    
    @objc func bookmarkTapped() {   // action when the user tapps the button (hence the bookmark button)
        
        if !isBookmarked {
            
            let alert    = UIAlertController(title: "Bookmarked!", message: "You have bookmarked this venue!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Sweet!", style: .default) { (action) in }
            
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
            if let bookmarkKey = bookmarkKey {
                UserDefaults.standard.set(true, forKey: bookmarkKey)
                isBookmarked = true
            }
            
        } else {
            
            let alert    = UIAlertController(title: "Bookmark Removed!", message: "You have remove the bookmark for this venue!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Thank you!", style: .default) { (action) in }
            
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
            if let bookmarkKey = bookmarkKey {
                UserDefaults.standard.set(false, forKey: bookmarkKey)
                isBookmarked = false
            }
        }
    }
    
    // MARK: CollectionViewController Creation
    static func create() -> VenuePhotosCollectionViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VenuePhotosCollectionViewController") as! VenuePhotosCollectionViewController
    }
    
    // MARK: Networking
    private func getVenueCollectionPhotosData() {
        NetworkingService.shared.getVenueCollectionPhotos(venueID: venueId!, success: { (urls) in
            self.dataSource = urls
        }) { (err) in }
    }
}
