//
//  VenueTableViewCell.swift
//  JEFIT Take Home Project
//
//  Created by George Garcia on 2/13/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var venueTitleLabel: UILabel!
    @IBOutlet weak var venueCategoryLabel: UILabel!
    @IBOutlet weak var venueLocationLabel: UILabel!
    
    // MARK: Properties
    var isBookmarked = false
    
    var data: Spot? {
        didSet {
            
            if let id = data?.venue.id {
                NetworkingService.shared.getVenuePhoto(venueID: id, success: { [weak self] (url) in
                    self?.venueImageView.download(url: url)
                }) { (err) in
                    self.venueImageView.image = UIImage(named: "no_image") // if no image, then show default image (instead of leaving it blank)
                }
            }
            
            venueTitleLabel.text    = data?.venue.name
            venueCategoryLabel.text = data?.venue.categories?.first?.name
            venueLocationLabel.text = data?.venue.location?.address
            setupVenueImage()
        }
    }
    
    // MARK: UI Customization
    
    // Customizing Image UI (hence: making a circular image)
    private func setupVenueImage() {
        venueImageView?.layer.cornerRadius  = venueImageView.frame.size.width / 2
        venueImageView?.clipsToBounds       = true
        venueImageView?.layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

