//
//  EpisodeListInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 09/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListInteractorInputProtocol
protocol EpisodeListInteractorInputProtocol: AnyObject {

    init(presenter: EpisodeListInteractorOutputProtocol)
}

// MARK: - EpisodeListInteractorOutputProtocol
protocol EpisodeListInteractorOutputProtocol {}

// MARK: - EpisodeListInteractor
final class EpisodeListInteractor: EpisodeListInteractorInputProtocol {

    var presenter: EpisodeListInteractorOutputProtocol?

    required init(presenter: EpisodeListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
