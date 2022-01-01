//
//  EpisodeDetailsAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 10/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeDetailsAssemblyProtocol
protocol EpisodeDetailsAssemblyProtocol {
    
    /// Собрать модуль `Episode`
    func configure(with viewController: EpisodeDetailsViewController)
}

// MARK: - EpisodeDetailsAssembly + EpisodeDetailsAssemblyProtocol
class EpisodeDetailsAssembly: EpisodeDetailsAssemblyProtocol {
    
    func configure(with viewController: EpisodeDetailsViewController) {
        let presenter = EpisodeDetailsPresenter(view: viewController)
        let interactor = EpisodeDetailsInteractor(presenter: presenter,
                                                  episodeService: EpisodeService())
        let router = EpisodeDetailsRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
