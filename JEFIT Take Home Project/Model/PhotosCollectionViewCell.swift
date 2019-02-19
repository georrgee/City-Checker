//  PhotosCollectionViewCell.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/13/19.
//  Copyright © 2019 George Garcia. All rights reserved.

//  Description: Here we can set the UICollectionViewCell's attributes. Where this will only display images (like a grid) for VenuePhotosCollectionViewController

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Properties
    var data: String? {
        didSet {
            photoImageView.download(url: data)
        }
    }
}
