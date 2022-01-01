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

    /// Инициализация интерактора модуля `EpisodeList`
    /// - Parameters:
    ///   - presenter: `EpisodeListPresenter`
    ///   - characterService: `EpisodeService`
    init(presenter: EpisodeListInteractorOutputProtocol, episodeService: EpisodeService)
    
    /// Получить информацию о серии
    /// - Parameter ids: ids серий
    func provideEpisodeList(with ids: [Int])
    
    /// Получить информацию о серии
    /// - Parameter id: id серии
    func provideEpisodeList(with id: Int)
}

// MARK: - EpisodeListInteractorOutputProtocol
protocol EpisodeListInteractorOutputProtocol {
    
    /// Получен список серий
    /// - Parameter list: список серий
    func receiveEpisodeList(_ list: [EpisodeModel])
    
    /// Получена информация о локации
    /// - Parameter episode: модель серии
    func receiveEpisodeList(_ episode: EpisodeModel)
}

// MARK: - EpisodeListInteractor
final class EpisodeListInteractor: EpisodeListInteractorInputProtocol {

    private let presenter: EpisodeListInteractorOutputProtocol?
    private let episodeService: EpisodeService

    required init(presenter: EpisodeListInteractorOutputProtocol, episodeService: EpisodeService) {
        self.presenter = presenter
        self.episodeService = episodeService
    }
    
    func provideEpisodeList(with ids: [Int]) {
        episodeService.fetchEpisodes(by: ids) { (result) in
            switch result {
            case .success(let list):
                self.presenter?.receiveEpisodeList(list)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    func provideEpisodeList(with id: Int) {
        episodeService.fetchEpisode(by: id) { (result) in
            switch result {
            case .success(let episode):
                self.presenter?.receiveEpisodeList(episode)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
