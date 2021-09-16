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
    
    func openEpisodeDetails(with: Int)
}

// MARK: - EpisodeListRouter + EpisodeListRouterProtocol
final class EpisodeListRouter: EpisodeListRouterProtocol {
    
    private let viewController: EpisodeListViewController?
    
    required init(viewController: EpisodeListViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeDetails(with id: Int) {
        viewController?.performSegue(withIdentifier: "showEpisode", sender: id)
    }
}
