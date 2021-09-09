//
//  EpisodeListPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 09/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListPresenter
final class EpisodeListPresenter: EpisodeListViewOutputProtocol {

    private let view: EpisodeListViewInputProtocol?
    var interactor: EpisodeListInteractorInputProtocol!
    var router: EpisodeListRouterProtocol!
    
    required init(view: EpisodeListViewInputProtocol) {
        self.view = view
    }
}

// MARK: - EpisodeListPresenter + EpisodeListInteractorOutputProtocol
extension EpisodeListPresenter: EpisodeListInteractorOutputProtocol {}
