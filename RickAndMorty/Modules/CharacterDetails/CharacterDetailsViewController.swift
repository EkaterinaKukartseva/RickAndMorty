//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 11.12.2020.
//

import UIKit

// MARK: - CharacterDetailsViewInputProtocol
protocol CharacterDetailsViewInputProtocol: AnyObject {
    
    func setCharacter(_ character: CharacterDetails)
}

// MARK: - CharacterDetailsViewOutputProtocol
protocol CharacterDetailsViewOutputProtocol {
    
    init(view: CharacterDetailsViewInputProtocol)
    
    func didTabShowCharacter(with id: Int)
    
    func showEpisodeList()
    
    func showLocation()
    
    func showOrigin()
}

// MARK: - CharacterDetailsViewController
class CharacterDetailsViewController: UIViewController {
    
    var presenter: CharacterDetailsViewOutputProtocol!
    private let assembly: CharacterDetailsAssemblyProtocol = CharacterDetailsAssembly()
    
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
    
    var characterId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter.didTabShowCharacter(with: characterId)
    }
    
    // MARK: - IBAction
    
    @IBAction func originViewTap(_ sender: UITapGestureRecognizer) {
        presenter.showOrigin()
    }
    
    @IBAction func locationViewTap(_ sender: UITapGestureRecognizer) {
        presenter.showLocation()
    }
    
    @IBAction func episodesViewTap(_ sender: UIButton) {
        presenter.showEpisodeList()
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EpisodesCollectionViewController {
            
//            for episodeUrl in character.episode {
//                let episodeId = episodeUrl.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
//                
//                if let id = Int(episodeId) {
//                    destination.ids.append(Int(id))
//                }
//            }
        } else if let destination = segue.destination as? LocationViewController {
            
            if let locationModel = sender as? LocationModel {
//                destination.location = locationModel
            }
        }
    }
}

// MARK: - CharacterViewController + CharacterViewInputProtocol
extension CharacterDetailsViewController: CharacterDetailsViewInputProtocol {
    
    func setCharacter(_ character: CharacterDetails) {
        name.text = character.name
        status.text = character.status
        species.text = character.species
        type.text = character.type
        gender.text = character.gender
        origin.text = character.origin.name
        location.text = character.location.name
        imageView.fetchImage(from: character.image)
    }
}
