//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 11.12.2020.
//

import UIKit

// MARK: - CharacterViewInputProtocol
protocol CharacterViewInputProtocol: AnyObject {
    
    func setCharacter(_ character: CharacterData)
}

// MARK: - CharacterViewOutputProtocol
protocol CharacterViewOutputProtocol {
    
    init(view: CharacterViewInputProtocol)
    
    func didTabShowCharacter()
}

// MARK: - CharacterViewController
class CharacterViewController: UIViewController {
    
    var presenter: CharacterViewOutputProtocol!
    private let assembly: CharacterAssemblyProtocol = CharacterAssembly()
    
    @IBOutlet var originView: UIView!
    @IBOutlet var locationView: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var species: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet var origin: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var imageView: CharacterImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.bounds.size.width / 2
            imageView.layer.borderWidth = 4
            imageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private let locationSegue = "showLocation"
    
    var character: CharacterModel!
    private var locationModel: LocationModel!
    private var originModel: LocationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(withView: self)
        presenter.didTabShowCharacter()
        
//        fetchLocationByURL(url: character.location.url)
//        fetchOriginByURL(url: character.origin.url)
//        imageView.fetchImage(from: character.image)
        
    }
    
    private func fetchLocationByURL(url: String) {
        client.location().fetchLocation(byURL: url) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.locationModel = model
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchOriginByURL(url: String) {
        client.location().fetchLocation(byURL: url) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.originModel = model
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func originViewTap(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: character.origin.url),
              UIApplication.shared.canOpenURL(url)
        else { return }
        performSegue(withIdentifier: locationSegue, sender: originModel)
    }
    
    @IBAction func locationViewTap(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: character.location.url),
              UIApplication.shared.canOpenURL(url)
        else { return }
        performSegue(withIdentifier: locationSegue, sender: locationModel)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesCollectionViewController {
            
            for episodeUrl in character.episode {
                let episodeId = episodeUrl.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
                
                if let id = Int(episodeId) {
                    destination.ids.append(Int(id))
                }
            }
        } else if let destination = segue.destination as? LocationViewController {
            
            if let locationModel = sender as? LocationModel {
                destination.location = locationModel
            }
        }
    }
}

// MARK: - CharacterViewController + CharacterViewInputProtocol
extension CharacterViewController: CharacterViewInputProtocol {
    
    func setCharacter(_ character: CharacterData) {
        name.text = character.name
        status.text = character.status
        species.text = character.species
        type.text = character.type
        gender.text = character.gender
        origin.text = character.origin.name
        location.text = character.location.name
    }
}
