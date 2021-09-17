//
//  EpisodeListPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 09/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - Episode
struct Episode {
    
    let id: Int
    let name: String
    let episode: String
}

// MARK: - EpisodeListPresenter
final class EpisodeListPresenter: EpisodeListViewOutputProtocol {

    private let view: EpisodeListViewInputProtocol?
    var interactor: EpisodeListInteractorInputProtocol!
    var router: EpisodeListRouterProtocol!
    
    required init(view: EpisodeListViewInputProtocol) {
        self.view = view
    }
    
    func showAllEpisodeList() {
        interactor.provideAllEpisodeList()
    }
    
    func showEpisodeList(with ids: [Int]) {
        interactor.provideEpisodeList(with: ids)
    }
    
    func showEpisodeList(with id: Int) {
        interactor.provideEpisodeList(with: id)
    }
    
    func showEpisodeDetails(with id: Int) {
        router.openEpisodeDetails(with: id)
    }
}

// MARK: - EpisodeListPresenter + EpisodeListInteractorOutputProtocol
extension EpisodeListPresenter: EpisodeListInteractorOutputProtocol {

    func receiveEpisodeList(_ list: [EpisodeModel]) {
        view?.setEpisodeList(list.map({ Episode(id: $0.id, name: $0.name, episode: $0.episode)}))
    }
    
    func receiveEpisodeList(_ episode: EpisodeModel) {
        view?.setEpisodeList([Episode(id: episode.id, name: episode.name, episode: episode.episode)])
    }
}
