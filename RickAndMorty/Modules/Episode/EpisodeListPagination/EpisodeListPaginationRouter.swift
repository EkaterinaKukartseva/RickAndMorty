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
    
    /// Открыть экран с детальной информацией о серии
    /// - Parameter id: id серии
    func openEpisodeDetailsModule(with id: Int)
}

// MARK: - EpisodeListPaginationRouter + EpisodeListPaginationRouterProtocol
final class EpisodeListPaginationRouter: EpisodeListPaginationRouterProtocol {
    
    private let viewController: EpisodeListPaginationViewController?
    
    required init(viewController: EpisodeListPaginationViewController) {
        self.viewController = viewController
    }
    
    func openEpisodeDetailsModule(with id: Int) {
        viewController?.performSegue(withIdentifier: "showEpisode", sender: id)
    }
}
