//
//  EpisodeListRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 09/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListRouterProtocol
protocol EpisodeListRouterProtocol {
    
    init(viewController: EpisodeListViewController)
    
    /// Открыть экран с детальной информацией о серии
    /// - Parameter id: id серии
    func openEpisodeDetailsModule(with id: Int)
}

// MARK: - EpisodeListRouter + EpisodeListRouterProtocol
final class EpisodeListRouter: EpisodeListRouterProtocol {
    
    private let viewController: EpisodeListViewController?
    
    required init(viewController: EpisodeListViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeDetailsModule(with id: Int) {
        viewController?.performSegue(withIdentifier: "showEpisode", sender: id)
    }
}
