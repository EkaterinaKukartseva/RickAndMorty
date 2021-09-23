//
//  LocationDetailsViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 11.12.2020.
//

import UIKit

// MARK: - LocationDetailsViewInputProtocol
protocol LocationDetailsViewInputProtocol: AnyObject {
    
    /// Получить информацию о локации
    /// - Parameter location: локацию
    func setLocation(_ location: LocationDetails)
}

// MARK: - LocationDetailsViewOutputProtocol
protocol LocationDetailsViewOutputProtocol {
    
    init(view: LocationDetailsViewInputProtocol)
    
    /// Отобразить информацию о локации
    /// - Parameter url: url локации
    func showLocation(with url: String)
    
    /// Открыть экран со списком участников
    func openCharacterListModule()
}

// MARK: - LocationDetailsViewController
class LocationDetailsViewController: UIViewController {
    
    var presenter: LocationDetailsViewOutputProtocol?
    private let assembly: LocationDetailsAssemblyProtocol = LocationDetailsAssembly()
    
    var locationUrl: String!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var dimension: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter?.showLocation(with: locationUrl)
    }
    
    @IBAction func characterViewTap(_ sender: UIButton) {
        presenter?.openCharacterListModule()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharacterListViewController,
              let ids = sender as? [Int]
        else { return }
        destination.ids = ids
    }
}

// MARK: - LocationDetailsViewController
extension LocationDetailsViewController: LocationDetailsViewInputProtocol {
    
    func setLocation(_ location: LocationDetails) {
        name.text = location.name
        type.text = location.type
        dimension.text = location.dimension
    }
}
