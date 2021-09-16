//
//  LocationDetailsViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 11.12.2020.
//

import UIKit

// MARK: - LocationDetailsViewInputProtocol
protocol LocationDetailsViewInputProtocol: AnyObject {
    
    func setLocation(_ location: LocationDetails)
}

// MARK: - LocationDetailsViewOutputProtocol
protocol LocationDetailsViewOutputProtocol {
    
    init(view: LocationDetailsViewInputProtocol)
    
    func didTabShowLocation(with url: String)
    
    func showCharacterList()
}

// MARK: - LocationDetailsViewController
class LocationDetailsViewController: UIViewController {
    
    var presenter: LocationDetailsViewOutputProtocol!
    private let assembly: LocationDetailsAssemblyProtocol = LocationDetailsAssembly()

    var locationUrl: String!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var dimension: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter.didTabShowLocation(with: locationUrl)
    }
    
    @IBAction func characterViewTap(_ sender: UIButton) {
        presenter.showCharacterList()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharacterListViewController,
              let ids = sender as? [Int]
              else { return }
        destination.ids = ids
//        guard let destination = segue.destination as? CharactersCollectionViewController else { return }
        
//        for residentUrl in location.residents {
//            let residentID = residentUrl.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
//            
//            if let id = Int(residentID) {
//                destination.ids.append(Int(id))
//            }
//        }
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
