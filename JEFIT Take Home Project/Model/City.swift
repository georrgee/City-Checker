//  City.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/18/19.
//  Copyright © 2019 George Garcia. All rights reserved.

//  Description: Here we have a struct of City where we can store the name, image, latitude and longitude 

import Foundation

struct City {
    
    var name:       String?
    var imageName:  String?
    
    var lat:  Double    = 0
    var long: Double    = 0
    
    init(name: String, image: String, lat: Double, long: Double) {
        self.name       = name
        self.imageName  = image
        self.lat        = lat
        self.long       = long
    }
}

