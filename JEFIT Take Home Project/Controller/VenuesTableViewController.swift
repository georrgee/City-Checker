//
//  VenuesTableViewController.swift
//  JEFIT Take Home Project
//
//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import UIKit

class VenuesTableViewController: UITableViewController {

    var city: City?
    
    var datasource = [Spot]() { didSet { tableView.reloadData() }}
    
    static func create() -> VenuesTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VenuesTableViewController") as! VenuesTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func getData() {
        
        guard let lat = city?.lat,
            let long = city?.long else { return }
        
        let exploreURL = "https://api.foursquare.com/v2/venues/explore?ll=\(lat),\(long)&section=\(section)&limit=30&client_id=\(client_id)&client_secret=\(client_secret)&v=20140714"
        
        guard let url = URL(string: exploreURL) else { return }
        NetworkingService.shared.getVenues(with: url, success: { (datas) in
            self.datasource = datas
        }) { (err) in
            // show message
            // empty state -> error image
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell", for: indexPath) as! VenueTableViewCell
        cell.data = datasource[indexPath.row]
        
        let longitude = datasource[indexPath.row].venue.location?.longitude
        let latitude  = datasource[indexPath.row].venue.location?.latitude
        
        var bookmarkKey = ""
        if let longitude = longitude, let latitude = latitude {
            bookmarkKey = "\(latitude)\(longitude)"
        }
        
        cell.isBookmarked = UserDefaults.standard.bool(forKey: bookmarkKey)
        cell.accessoryType = cell.isBookmarked ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let longitude = datasource[indexPath.row].venue.location?.longitude
        let latitude = datasource[indexPath.row].venue.location?.latitude
        
        var bookmarkKey = ""
        if let longitude = longitude, let latitude = latitude {
            bookmarkKey = "\(latitude)\(longitude)"
        }
        
        let controller = VenuePhotosCollectionViewController.create()
        controller.venueId = datasource[indexPath.row].venue.id
        controller.title = datasource[indexPath.row].venue.name
        controller.bookmarkKey = bookmarkKey
        controller.isBookmarked = UserDefaults.standard.bool(forKey: bookmarkKey)
        navigationController?.pushViewController(controller, animated: true)
    }
}

