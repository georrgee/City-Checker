//  CitiesTableViewController.swift
//  JEFIT Take Home Project
//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.

//  Description: A UITableView that shows a list of Cities (chosen) with their name and image

import UIKit

class CitiesTableViewController: UITableViewController {
    
    // MARK: Properties
    private let cellID = "CityContentsTableViewCell"    // cell reuse Identifier
    
    // An Array of City
    var datasource = [
        City(name: "Palmdale, CA", image: "palmdale", lat: 34.6, long: -118.1),
        City(name: "Los Angeles, CA", image: "los_angeles", lat: 34.0, long: -118.2),
        City(name: "San Francisco, CA", image: "san_francisco", lat: 37.7, long: -122.4),
        City(name: "Tokyo, Japan", image: "tokyo", lat: 35.6, long: 139.8),
        City(name: "Houston, CA", image: "houston", lat: 29.7, long: 95.3)
    ]
    
    //MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        setupNavigationBar()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count // return the amount of data to the table (5 cities = 5 cells)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell      = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CityContentsTableViewCell
        cell.cityData = datasource[indexPath.row]   // we have already set the Cell's Labels, images, etc. 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {    // when user taps a specific cell
        
        let controller      = VenuesTableViewController.create()    // create a VenuesTableViewController
        controller.city     = datasource[indexPath.row]             // set the city for the next screen
        controller.title    = datasource[indexPath.row].name        // set the Navigation Bar Title (by using the name of City)
        
        navigationController?.pushViewController(controller, animated: true)    // go to the next screen (VenuesTableViewController)
    }
    
    // MARK: Navigation Customization
    private func setupNavigationBar() {
        
        self.navigationItem.title = "City Checker"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 28)!
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Avenir", size: 22)!
        ]
    }
}
