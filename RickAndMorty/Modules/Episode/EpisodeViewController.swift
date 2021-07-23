//
//  EpisodeViewController.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 12.12.2020.
//

import UIKit

// MARK: EpisodeViewController
class EpisodeViewController: UIViewController {
    
    var episodeModel: EpisodeModel!
    var viewModel: EpisodeViewModelProtocol! {
        didSet {
            name.text = episodeModel.name
            episode.text = episodeModel.episode
            airDate.text = episodeModel.airDate
        }
    }
    
    @IBOutlet var episode: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var airDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EpisodeViewModel(episode: episodeModel)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharactersCollectionViewController else { return }
        
        for residentUrl in episodeModel.characters {
            let residentID = residentUrl.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
            
            if let id = Int(residentID) {
                destination.ids.append(Int(id))
            }
        }
    }
}
