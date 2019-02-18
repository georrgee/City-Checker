//  NetworkingService.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingService {
    
    static let shared = NetworkingService()

    func getVenues(with url: URL, success: @escaping (_ spot: [Spot]) -> Void, failure: @escaping(_ error: Error) -> Void) {
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess {
                let venueJSON = JSON(response.result.value!)
                print("VENUE JSON (from NetworkingService): \(venueJSON)")
                
                let venus   = venueJSON["response"]["groups"][0]["items"].arrayValue
                let results = venus.map({ return Spot(rawData: $0) })
                print("RESULTS COUNT (from NetworkingService): \(results.count)")
                
                success(results)
            } else {
                if let err = response.error {
                    failure(err)
                }
            }
        }
    }
    
    func getVenuePhoto(venueID: String, success: @escaping (_ url: String) -> Void, failure: @escaping(_ error: Error) -> Void) {
        
        let getPhotoAPI = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(client_id)&client_secret=\(client_secret)&v=20140714"
        
        guard let url = URL(string: getPhotoAPI) else { return }
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess {
                print("Photo Response: \(response)")
                // you have to get data here
                let rawData = JSON(response.result.value!)
                let photo = rawData["response"]["photos"]["items"].arrayValue.first
                
                if let prefix = photo?["prefix"].stringValue, let suffix = photo?["suffix"].stringValue {
                    let photoUrl = "\(prefix)" + "200x200" + "\(suffix)"
                    success(photoUrl)
                }
                
            } else {
                if let err = response.error {
                    failure(err)
                }
            }
        }
    }
    
    func getCollectionPhotos(venueID: String, success: @escaping (_ url: [String]) -> Void, failure: @escaping(_ error: Error) -> Void) {
    
        let getPhotoAPI = "https://api.foursquare.com/v2/venues/\(venueID)/photos?&limit=50&client_id=\(client_id)&client_secret=\(client_secret)&v=20140714"

        guard let url = URL(string: getPhotoAPI) else { return }
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess {
                print("Photo Response but this is for COLLECTION: \(response)")
                
                let rawData = JSON(response.result.value!)
                let photoRaw = rawData["response"]["photos"]["items"].arrayValue
              
                var photos = [String]()
                for raw in photoRaw {
                    // if string is nil -> reutrn ""
                    
                    let prefix = raw["prefix"].stringValue
                    let suffix = raw["suffix"].stringValue
                    let photoURL = "\(prefix)" + "200x200" + "\(suffix)"
                    photos.append(photoURL)
                    print("RAW INDEX: \(raw)")
                }
                success(photos)

            } else {
                if let err = response.error {
                    failure(err)
                }
            }
            
        }
    }
}
