//  CityContentsTableViewCell.swift
//  JEFIT Take Home Project

//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.

import UIKit

class CityContentsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityTitleLabel: UILabel!
    
    var cityData: City? {
        didSet {
            cityImageView.image = UIImage(named: (cityData?.imageName ?? "") + ".jpg")
            cityTitleLabel.text = cityData?.name
            setupCityImage()
        }
    }
    
    private func setupCityImage() {
        cityImageView?.layer.cornerRadius  = ((cityImageView?.frame.size.height)!) / 2
        cityImageView?.clipsToBounds       = true
        cityImageView?.layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
