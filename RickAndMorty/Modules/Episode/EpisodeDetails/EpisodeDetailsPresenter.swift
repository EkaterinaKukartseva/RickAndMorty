//
//  EpisodeDetailsPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 10/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeDetails
struct EpisodeDetails {
    
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
}

// MARK: - EpisodeDetailsPresenter
final class EpisodeDetailsPresenter: EpisodeDetailsViewOutputProtocol {

    private let view: EpisodeDetailsViewInputProtocol?
    var interactor: EpisodeDetailsInteractorInputProtocol!
    var router: EpisodeDetailsRouterProtocol!
    
    private var episode: EpisodeDetails!
    
    required init(view: EpisodeDetailsViewInputProtocol) {
        self.view = view
    }
    
    func didTabShowEpisode(with id: Int) {
        interactor.provideEpisode(with: id)
    }
    
    func showCharacterList() {
        router.openCharacterListModule(with: episode.characters.compactMap({Int($0.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression))}))
    }
}

// MARK: - EpisodeDetailsPresenter + EpisodeDetailsInteractorOutputProtocol
extension EpisodeDetailsPresenter: EpisodeDetailsInteractorOutputProtocol {
    
    func receiveEpisode(_ episode: EpisodeModel) {
        self.episode = EpisodeDetails(name: episode.name,
                                      airDate: episode.airDate,
                                      episode: episode.episode,
                                      characters: episode.characters)
        view?.setEpisode(self.episode)
    }
}
