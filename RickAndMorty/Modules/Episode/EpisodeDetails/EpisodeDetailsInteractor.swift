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

    /// Инициализация интерактора модуля `EpisodeDetails`
    /// - Parameters:
    ///   - presenter: `EpisodeDetailsPresenter`
    ///   - characterService: `EpisodeService`
    init(presenter: EpisodeDetailsInteractorOutputProtocol, episodeService: EpisodeService)
    
    /// Получить информацию о серии
    /// - Parameter id: id серии
    func provideEpisode(with id: Int)
}

// MARK: - EpisodeDetailsInteractorOutputProtocol
protocol EpisodeDetailsInteractorOutputProtocol {
    
    /// Получена информация о серии
    /// - Parameter episode: модель серии
    func receiveEpisode(_ episode: EpisodeModel)
}

// MARK: - EpisodeDetailsInteractor
final class EpisodeDetailsInteractor: EpisodeDetailsInteractorInputProtocol {

    private let presenter: EpisodeDetailsInteractorOutputProtocol?
    private let episodeService: EpisodeService

    required init(presenter: EpisodeDetailsInteractorOutputProtocol, episodeService: EpisodeService) {
        self.presenter = presenter
        self.episodeService = episodeService
    }
    
    func provideEpisode(with id: Int) {
        episodeService.fetchEpisode(by: id) { (result) in
            switch result {
            case .success(let model):
                self.presenter?.receiveEpisode(model)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
