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
    
    func provideAllEpisodeList()
    
    func provideEpisodeList(with ids: [Int])
    
    func provideEpisodeList(with id: Int)
}

// MARK: - EpisodeListInteractorOutputProtocol
protocol EpisodeListInteractorOutputProtocol {
    
    func receiveEpisodeList(_ list: [EpisodeModel])
    
    func receiveEpisodeList(_ episode: EpisodeModel)
}

// MARK: - EpisodeListInteractor
final class EpisodeListInteractor: EpisodeListInteractorInputProtocol {

    private let presenter: EpisodeListInteractorOutputProtocol?

    required init(presenter: EpisodeListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideAllEpisodeList() {
        client.episode().fetchEpisodes { result in
            switch result {
            case .success(let list):
                self.presenter?.receiveEpisodeList(list.results)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    func provideEpisodeList(with ids: [Int]) {
        client.episode().fetchEpisodes(byID: ids) { (result) in
            switch result {
            case .success(let list):
                self.presenter?.receiveEpisodeList(list)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    func provideEpisodeList(with id: Int) {
        client.episode().fetchEpisode(byID: id) { (result) in
            switch result {
            case .success(let episode):
                self.presenter?.receiveEpisodeList(episode)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
