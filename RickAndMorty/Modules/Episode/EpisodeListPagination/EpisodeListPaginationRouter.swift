//
//  EpisodeListPaginationRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListPaginationRouterProtocol
protocol EpisodeListPaginationRouterProtocol {
    
    init(viewController: EpisodeListPaginationViewController)
    
    func openEpisodeDetails(with id: Int)
}

// MARK: - EpisodeListPaginationRouter + EpisodeListPaginationRouterProtocol
final class EpisodeListPaginationRouter: EpisodeListPaginationRouterProtocol {
    
    private let viewController: EpisodeListPaginationViewController?
    
    required init(viewController: EpisodeListPaginationViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeDetails(with id: Int) {
        viewController?.performSegue(withIdentifier: "showEpisode", sender: id)
    }
}
