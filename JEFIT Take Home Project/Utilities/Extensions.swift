//  Extensions.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/15/19.
//  Copyright © 2019 George Garcia. All rights reserved.

//  Description: Here we can have extensions so we can avoid redundancy. So we can use the function globally

import Foundation
import AlamofireImage

// MARK: Extensions
extension UIImageView {
    
    func download(url: String?) {  
        if let string = url, let link = URL(string: string) {
            af_setImage(withURL: link)
        }
    }
    
}
