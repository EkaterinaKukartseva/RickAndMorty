//
//  EpisodeListPaginationPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - InfoEpisode
struct InfoEpisode {
    
    let info: Info
    let results: [Episode]
}

// MARK: - EpisodeListPaginationPresenter
final class EpisodeListPaginationPresenter: EpisodeListPaginationViewOutputProtocol {

    private let view: EpisodeListPaginationViewInputProtocol?
    var interactor: EpisodeListPaginationInteractorInputProtocol!
    var router: EpisodeListPaginationRouterProtocol!
    
    required init(view: EpisodeListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showEpisodeList(by page: Int) {
        interactor.provideEpisodeList(by: page)
    }
    
    func showEpisodeDetails(with id: Int) {
        router.openEpisodeDetailsModule(with: id)
    }
}

// MARK: - EpisodeListPaginationPresenter + EpisodeListPaginationInteractorOutputProtocol
extension EpisodeListPaginationPresenter: EpisodeListPaginationInteractorOutputProtocol {
    
    func receiveEpisodeList(_ model: InfoEpisodeModel) {
        view?.setEpisodeList(.init(model: model))
    }
}

// MARK: - InfoEpisode + init
private extension InfoEpisode {
    
    init(model: InfoEpisodeModel) {
        self.info = .init(info: model.info)
        self.results = model.results.map({ .init(model: $0) })
    }
}

// MARK: - Episode + init
private extension Episode {
    
    init(model: EpisodeModel) {
        self.id = model.id
        self.name = model.name
        self.episode = model.episode
    }
}
