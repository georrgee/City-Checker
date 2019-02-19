//  NetworkingService.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.

// Description: This file contains all the HTTP requests to grab data from FourSquare's API

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingService {
    
    // MARK: Properties
    static let shared = NetworkingService()     // Creating an instance of NetworkingService; We can use this for the View Controllers
    
    // MARK: HTTP REQUESTS
    
        // function that retrieves all the venues for a specific location
    func getVenues(with url: URL, success: @escaping (_ spot: [Spot]) -> Void, failure: @escaping(_ error: Error) -> Void) {
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess {  // basically: if we do manage to get the results (data), proceed to getting the specific data
                
                let rawData     = JSON(response.result.value!)                              // Store JSON Data
                let items       = rawData["response"]["groups"][0]["items"].arrayValue    // Create a constant where it stores all venues
                let venues      = items.map({ return Spot(rawData: $0) })  // Assign the data to the struct's (Spot) properties so we can use them for the labels etc
                
                success(venues)
            } else {
                if let err = response.error { // display the error to console
                    failure(err)
                }
            }
        }
    }
        // function that only retrieves a photo for a venue
    func getVenuePhoto(venueID: String, success: @escaping (_ url: String) -> Void, failure: @escaping(_ error: Error) -> Void) {
        
        let getPhotoApiURL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(client_id)&client_secret=\(client_secret)&v=20190219"
        guard let url      = URL(string: getPhotoApiURL) else { return }
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess {
                
                let rawData   = JSON(response.result.value!)
                let photo     = rawData["response"]["photos"]["items"].arrayValue.first // find the specific arra and store the first element only
                
                if let prefix = photo?["prefix"].stringValue, let suffix = photo?["suffix"].stringValue {   // get the string of the prefix and suffix
                    
                    let photoUrl = "\(prefix)" + "200x200" + "\(suffix)"
                    // combined the two to create the Photo's URL (i.e. Prefix(address) + size of photo + suffix(/BWWLKDKFJ40VFXK.jpg
                    
                    success(photoUrl)       // return the photo's URL
                }
                
            } else {
                if let err = response.error {
                    failure(err)
                }
            }
        }
    }
        // this function retrieves the amount of photos for a specifc venue
    func getVenueCollectionPhotos(venueID: String, success: @escaping (_ url: [String]) -> Void, failure: @escaping(_ error: Error) -> Void) {
        
        // here we set the limit to 50, meaning we want to get 50 photos of a specific Venue (&limit=50)
        let getPhotoApiURL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?&limit=50&client_id=\(client_id)&client_secret=\(client_secret)&v=20190218"
        guard let url   = URL(string: getPhotoApiURL) else { return }
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess {
                
                let rawData = JSON(response.result.value!)
                let photoRaw = rawData["response"]["photos"]["items"].arrayValue
              
                var photoURLArray = [String]()     // create an array of strings (we can store the string of URLS here!)
                
                for raw in photoRaw {
                    
                    let prefix = raw["prefix"].stringValue                  // store the prefix
                    let suffix = raw["suffix"].stringValue                  // store the suffix
                    let photoURL = "\(prefix)" + "200x200" + "\(suffix)"    // with the photo size, combine all strings to create URL
                    photoURLArray.append(photoURL)                          // add the URL to the string array
                    
                }
                success(photoURLArray)

            } else {
                if let err = response.error {
                    failure(err)
                }
            }
        }
    }
}
