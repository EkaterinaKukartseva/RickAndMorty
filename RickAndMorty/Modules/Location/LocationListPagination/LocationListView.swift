//
//  LocationListPaginationViewController.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import UIKit

// MARK: - LocationListPaginationViewInputProtocol
protocol LocationListPaginationViewInputProtocol: AnyObject {
    
    func setLocationList(_ list: [Location])
}

// MARK: - LocationListPaginationViewOutputProtocol
protocol LocationListPaginationViewOutputProtocol {
    
    init(view: LocationListPaginationViewInputProtocol)
    
    func showAllLocationList()
}

// MARK: - LocationListPaginationViewController
final class LocationListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LocationListPaginationViewOutputProtocol!
    private let assembly: LocationListPaginationAssemblyProtocol = LocationListPaginationAssembly()
    
    var locations: [Location] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter.showAllLocationList()
    }
}

// MARK: - LocationListPaginationViewController + UITableViewDataSource
extension LocationListPaginationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        let location = locations[indexPath.row]
        cell.configure(model: location)
        return cell
    }
}

// MARK: - LocationListPaginationViewController + UITableViewDelegate
extension LocationListPaginationViewController: UITableViewDelegate {
    
}

// MARK: - LocationListPaginationViewController + LocationListViewInputProtocol
extension LocationListPaginationViewController: LocationListPaginationViewInputProtocol {
    
    func setLocationList(_ list: [Location]) {
        locations = list
        tableView.reloadData()
    }
}
