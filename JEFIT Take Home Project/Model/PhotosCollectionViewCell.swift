//
//  PhotosCollectionViewCell.swift
//  JEFIT Take Home Project
//
//  Created by George Garcia on 2/13/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var data: String? {
        didSet {
            photoImageView.download(url: data)
        }
    }
}
