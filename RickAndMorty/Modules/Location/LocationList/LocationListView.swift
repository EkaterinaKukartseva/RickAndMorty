//
//  LocationListView.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import UIKit

// MARK: - LocationListViewInputProtocol
protocol LocationListViewInputProtocol: AnyObject {
    
    func setLocationList(_ list: [Location])
}

// MARK: - LocationListViewOutputProtocol
protocol LocationListViewOutputProtocol {
    
    init(view: LocationListViewInputProtocol)
    
    func showAllLocationList()
}

// MARK: - LocationListViewController
final class LocationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LocationListViewOutputProtocol!
    private let assembly: LocationListAssemblyProtocol = LocationListAssembly()
    
    var locations: [Location] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter.showAllLocationList()
    }
}

// MARK: - LocationListViewController + UITableViewDataSource
extension LocationListViewController: UITableViewDataSource {
    
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

// MARK: - LocationListViewController + UITableViewDelegate
extension LocationListViewController: UITableViewDelegate {
    
}

// MARK: - LocationListViewController + LocationListViewInputProtocol
extension LocationListViewController: LocationListViewInputProtocol {
    
    func setLocationList(_ list: [Location]) {
        locations = list
        tableView.reloadData()
    }
}
