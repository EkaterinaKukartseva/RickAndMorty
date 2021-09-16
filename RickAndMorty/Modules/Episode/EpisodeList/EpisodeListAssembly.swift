//
//  EpisodeListAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 09/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListAssemblyProtocol
protocol EpisodeListAssemblyProtocol {
    
    func configure(with viewController: EpisodeListViewController)
}

// MARK: - EpisodeListAssembly + EpisodeListAssemblyProtocol
class EpisodeListAssembly: EpisodeListAssemblyProtocol {
    
    func configure(with viewController: EpisodeListViewController) {
        let presenter = EpisodeListPresenter(view: viewController)
        let interactor = EpisodeListInteractor(presenter: presenter)
        let router = EpisodeListRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
