//
//  EpisodeDetailsInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 10/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - EpisodeDetailsInteractorInputProtocol
protocol EpisodeDetailsInteractorInputProtocol: AnyObject {

    init(presenter: EpisodeDetailsInteractorOutputProtocol)
    
    func provideEpisode(with id: Int)
}

// MARK: - EpisodeDetailsInteractorOutputProtocol
protocol EpisodeDetailsInteractorOutputProtocol {
    
    func receiveEpisode(_ episode: EpisodeModel)
}

// MARK: - EpisodeDetailsInteractor
final class EpisodeDetailsInteractor: EpisodeDetailsInteractorInputProtocol {

    private let presenter: EpisodeDetailsInteractorOutputProtocol?

    required init(presenter: EpisodeDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideEpisode(with id: Int) {
        client.episode().fetchEpisode(byID: id) { (result) in
            switch result {
            case .success(let model):
                self.presenter?.receiveEpisode(model)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
