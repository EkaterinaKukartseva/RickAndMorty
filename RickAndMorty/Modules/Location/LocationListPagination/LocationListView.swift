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
    
    func setLocationList(_ list: InfoLocation)
}

// MARK: - LocationListPaginationViewOutputProtocol
protocol LocationListPaginationViewOutputProtocol {
    
    init(view: LocationListPaginationViewInputProtocol)
    
    func showAllLocationList(by page: Int)
    
    func showLocationDetails(with url: String)
}

// MARK: - LocationListPaginationViewController
final class LocationListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LocationListPaginationViewOutputProtocol!
    private let assembly: LocationListPaginationAssemblyProtocol = LocationListPaginationAssembly()
    
    private var info: Info!
    private var currentPageLocation = 1
    private var locations: [Location] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        tableView.register(UINib(nibName: "LoadingCell", bundle: .main), forCellReuseIdentifier: "LoadingCell")
        tableView.register(UINib(nibName: "LocationCell", bundle: .main), forCellReuseIdentifier: "LocationCell")
        presenter.showAllLocationList(by: currentPageLocation)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocationDetailsViewController {
            if let url = sender as? String {
                destination.locationUrl = url
            }
        }
    }
}

// MARK: - LocationListPaginationViewController + UITableViewDataSource
extension LocationListPaginationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == locations.count - 1 && currentPageLocation <= info.pages {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            presenter?.showAllLocationList(by: currentPageLocation)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let location = locations[indexPath.row]
        cell.configure(model: location)
        return cell
    }
}

// MARK: - LocationListPaginationViewController + UITableViewDelegate
extension LocationListPaginationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        presenter?.showLocationDetails(with: location.url)
    }
}

// MARK: - LocationListPaginationViewController + LocationListViewInputProtocol
extension LocationListPaginationViewController: LocationListPaginationViewInputProtocol {
    
    func setLocationList(_ list: InfoLocation) {
        locations.append(contentsOf: list.results)
        info = list.info
        currentPageLocation += 1
        tableView.reloadData()
    }
}
