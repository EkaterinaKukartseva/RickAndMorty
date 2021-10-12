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
    
    /// Получен список локаций
    /// - Parameters:
    ///   - list: список kjrfwbq
    ///   - isNextPage: true - есть следующая страница
    func setLocationList(_ list: [Location], isNextPage: Bool)
    
    /// Получена следующая страница
    /// - Parameter state: true - есть следующая страница
    func setPageLoading(with state: Bool)
}

// MARK: - LocationListPaginationViewOutputProtocol
protocol LocationListPaginationViewOutputProtocol {
    
    init(view: LocationListPaginationViewInputProtocol)
    
    /// Показать список локаций по странице
    func showLocationList()
    
    /// Показать список серий на следующей странице
    func showLocationListNextPage()
    
    /// Показать детальную информацию о локации
    /// - Parameter url: url локации
    func openLocationDetails(with url: String)
}

// MARK: - LocationListPaginationViewController
final class LocationListPaginationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LocationListPaginationViewOutputProtocol?
    private let assembly: LocationListPaginationAssemblyProtocol = LocationListPaginationAssembly()
    
    private var locations: [Location] = []
    private var isLoadingNextPage = false

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        tableView.register(LocationCell.nib, forCellReuseIdentifier: LocationCell.identifier)
        presenter?.showLocationList()
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
        checkLoadingNextPage(for: indexPath)
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
        presenter?.openLocationDetails(with: location.url)
    }
}

// MARK: - LocationListPaginationViewController + LocationListViewInputProtocol
extension LocationListPaginationViewController: LocationListPaginationViewInputProtocol {
    
    func setLocationList(_ list: [Location], isNextPage: Bool) {
        isNextPage ? append(content: list) : set(content: list)
    }
    
    func setPageLoading(with state: Bool) {
        isLoadingNextPage = state
        guard isLoadingNextPage else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tableView.tableFooterView = UIView()
            }
            return
        }
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: CGFloat(60))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
}

private extension LocationListPaginationViewController {
    
    func set(content: [Location]) {
        self.locations = content
        tableView.reloadData()
    }
    
    func append(content: [Location]) {
        let oldCount = self.locations.count
        self.locations.append(contentsOf: content)
        let indexPaths = (oldCount..<self.locations.count).map { IndexPath(row: $0, section: 0) }
        setPageLoading(with: false)
        UIView.performWithoutAnimation {
            self.tableView.insertRows(at: indexPaths, with: .bottom)
        }
    }
    
    func checkLoadingNextPage(for indexPath: IndexPath) {
        guard !isLoadingNextPage else { return }
        if indexPath.row == (locations.count - 2) {
            presenter?.showLocationListNextPage()
        }
    }
}
