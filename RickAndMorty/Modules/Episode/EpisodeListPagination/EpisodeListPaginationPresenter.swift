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
    
    private var currentPage = 1
    private var info: Info!
    private var isNextPageAvailable = true
    
    required init(view: EpisodeListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showEpisodeList() {
        interactor.provideEpisodeList(by: currentPage)
    }
    
    func showEpisodeListNextPage() {
        guard isNextPageAvailable else { return }
        view?.setPageLoading(with: true)
        currentPage += 1
        interactor.provideEpisodeList(by: currentPage)
    }
    
    func showEpisodeDetails(with id: Int) {
        router.openEpisodeDetailsModule(with: id)
    }
}

// MARK: - EpisodeListPaginationPresenter + EpisodeListPaginationInteractorOutputProtocol
extension EpisodeListPaginationPresenter: EpisodeListPaginationInteractorOutputProtocol {
    
    func receiveEpisodeList(_ model: InfoEpisodeModel) {
        self.info = Info(info: model.info)
        isNextPageAvailable = info.next != nil
        view?.setEpisodeList(model.results.map { .init($0) }, isNextPage: info.prev != nil)
    }
}

// MARK: - Episode + init
private extension Episode {
    
    init(_ model: EpisodeModel) {
        self.id = model.id
        self.name = model.name
        self.episode = model.episode
    }
}
