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
    
    /// Получить список локаций
    /// - Parameter info: информация о странице со списком локаций
    func setLocationList(_ info: InfoLocation)
}

// MARK: - LocationListPaginationViewOutputProtocol
protocol LocationListPaginationViewOutputProtocol {
    
    init(view: LocationListPaginationViewInputProtocol)
    
    /// Показать список локаций по странице
    /// - Parameter page: номер страницы
    func showLocationList(by page: Int)
    
    /// Открыть экран с детальной информацией о локации
    /// - Parameter url: url локации
    func openLocationDetailsModule(with url: String)
}

// MARK: - LocationListPaginationViewController
final class LocationListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LocationListPaginationViewOutputProtocol?
    private let assembly: LocationListPaginationAssemblyProtocol = LocationListPaginationAssembly()
    
    private var info: Info!
    private var currentPageLocation = 1
    private var locations: [Location] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        tableView.register(UINib(nibName: "LoadingCell", bundle: .main), forCellReuseIdentifier: "LoadingCell")
        tableView.register(LocationCell.nib, forCellReuseIdentifier: LocationCell.identifier)
        presenter?.showLocationList(by: currentPageLocation)
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
            presenter?.showLocationList(by: currentPageLocation)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as! LocationCell
        let location = locations[indexPath.row]
        cell.configure(model: location)
        return cell
    }
}

// MARK: - LocationListPaginationViewController + UITableViewDelegate
extension LocationListPaginationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        presenter?.openLocationDetailsModule(with: location.url)
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
