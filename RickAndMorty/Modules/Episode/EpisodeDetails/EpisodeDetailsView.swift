//
//  EpisodeDetailsView.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 10/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import UIKit

// MARK: - EpisodeDetailsViewInputProtocol
protocol EpisodeDetailsViewInputProtocol: AnyObject {
    
    /// Получена информация о серии
    /// - Parameter content: серия
    func setEpisode(_ content: EpisodeDetails)
}

// MARK: - EpisodeDetailsViewOutputProtocol
protocol EpisodeDetailsViewOutputProtocol {
    
    init(view: EpisodeDetailsViewInputProtocol)
    
    ///  Показать информацию о серии
    /// - Parameter id: id серии
    func didTabShowEpisode(with id: Int)
    
    /// Показать список персонажей
    func showCharacterList()
}

// MARK: - EpisodeDetailsViewController
final class EpisodeDetailsViewController: UIViewController {

    var presenter: EpisodeDetailsViewOutputProtocol?
    private let assembly: EpisodeDetailsAssemblyProtocol = EpisodeDetailsAssembly()
    
    @IBOutlet var episode: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var airDate: UILabel!
    
    var episodeId: Int!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        presenter?.didTabShowEpisode(with: episodeId)
    }
    
    // MARK: - Navigation

    @IBAction func charactersViewTap(_ sender: UIButton) {
        presenter?.showCharacterList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharacterListViewController,
              let ids = sender as? [Int] else { return }
        destination.ids = ids
    }
}

// MARK: - EpisodeDetailsViewController + EpisodeDetailsViewInputProtocol
extension EpisodeDetailsViewController: EpisodeDetailsViewInputProtocol {
    
    func setEpisode(_ content: EpisodeDetails) {
        episode.text = content.episode
        name.text = content.name
        airDate.text = content.airDate
    }
}
