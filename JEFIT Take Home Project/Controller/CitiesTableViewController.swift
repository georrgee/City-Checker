//  CitiesTableViewController.swift
//  JEFIT Take Home Project
//
//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    private let cellID = "CityContentsTableViewCell"
    
    var datasource = [
        City(name: "Palmdale, CA", image: "palmdale", lat: 34.6, long: -118.1),
        City(name: "Los Angeles, CA", image: "los_angeles", lat: 34.0, long: -118.2),
        City(name: "San Francisco, CA", image: "san_francisco", lat: 37.7, long: -122.4),
        City(name: "Tokyo, Japan", image: "tokyo", lat: 35.6, long: 139.8),
        City(name: "Houston, CA", image: "houston", lat: 29.7, long: 95.3)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "City Checker"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 28)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Avenir", size: 22)!]
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CityContentsTableViewCell
        cell.cityData = datasource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = VenuesTableViewController.create()
        controller.city = datasource[indexPath.row]
        controller.title = datasource[indexPath.row].name
        navigationController?.pushViewController(controller, animated: true)
    }
}
