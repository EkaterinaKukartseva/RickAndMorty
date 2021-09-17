//
//  EpisodeListPaginationInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeListPaginationInteractorInputProtocol
protocol EpisodeListPaginationInteractorInputProtocol: AnyObject {

    init(presenter: EpisodeListPaginationInteractorOutputProtocol)
    
    func provideEpisodeList(by page: Int)
}

// MARK: - EpisodeListPaginationInteractorOutputProtocol
protocol EpisodeListPaginationInteractorOutputProtocol {
    
    func receiveEpisodeList(_ model: InfoEpisodeModel)
}

// MARK: - EpisodeListPaginationInteractor
final class EpisodeListPaginationInteractor: EpisodeListPaginationInteractorInputProtocol {

    var presenter: EpisodeListPaginationInteractorOutputProtocol?

    required init(presenter: EpisodeListPaginationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideEpisodeList(by page: Int) {
        client.episode().fetchEpisodes(byPageNumber: page) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveEpisodeList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
