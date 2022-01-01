//
//  EpisodeListPaginationAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListPaginationAssemblyProtocol
protocol EpisodeListPaginationAssemblyProtocol {
    
    /// Собрать модуль `EpisodeListPagination`
    func configure(with viewController: EpisodeListPaginationViewController)
}

// MARK: - EpisodeListPaginationAssembly + EpisodeListPaginationAssemblyProtocol
class EpisodeListPaginationAssembly: EpisodeListPaginationAssemblyProtocol {
    
    func configure(with viewController: EpisodeListPaginationViewController) {
        let presenter = EpisodeListPaginationPresenter(view: viewController)
        let interactor = EpisodeListPaginationInteractor(presenter: presenter,
                                                         episodeService: EpisodeService())
        let router = EpisodeListPaginationRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
