//
//  EpisodeDetailsRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 10/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeDetailsRouterProtocol
protocol EpisodeDetailsRouterProtocol {
    
    init(viewController: EpisodeDetailsViewController)
    
    /// Открыть экран со списком персонажей
    /// - Parameter ids: ids персонажей
    func openCharacterListModule(with ids: [Int])
}

// MARK: - EpisodeDetailsRouter + EpisodeDetailsRouterProtocol
final class EpisodeDetailsRouter: EpisodeDetailsRouterProtocol {

    private let viewController: EpisodeDetailsViewController?
    
    required init(viewController: EpisodeDetailsViewController) {
        self.viewController = viewController
    }
    
    func openCharacterListModule(with ids: [Int]) {
        viewController?.performSegue(withIdentifier: "characterList", sender: ids)
    }
}
