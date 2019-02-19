//  Venue.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.

//  Description: Struct file to store all the data 

import Foundation
import SwiftyJSON

struct Spot {   
    
    var venue: Venue
    
    init(rawData: JSON) {
        
        let venueTemp       = rawData["venue"]
        let locationTemp    = venueTemp["location"]
        
        let location = Location(
            state:     locationTemp["state"].stringValue,
            city:      locationTemp["city"].stringValue,
            longitude: locationTemp["lng"].doubleValue,
            latitude:  locationTemp["lat"].doubleValue,
            address:   locationTemp["address"].stringValue )
        
        var categories = [Category]()
        for cat in venueTemp["categories"].arrayValue {
            let category = Category(name: cat["name"].stringValue)
            categories.append(category)
        }
    
        let venueItem = Venue(name: venueTemp["name"].stringValue, location: location, id: venueTemp["id"].stringValue, categories: categories)
        self.venue = venueItem
    }
}

struct Venue {
    var name:         String
    var location:     Location?
    var id:           String?
    var categories:   [Category]?
}

struct Location {
    var state:        String?
    var city:         String?
    var longitude:    Double?
    var latitude:     Double?
    var address:      String?
}

struct Category {
    var name: String
}
