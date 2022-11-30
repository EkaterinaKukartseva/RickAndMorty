//
//  EpisodeDetailsInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 10/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation
import Combine

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
    private let episodeService: EpisodeServiceProtocol
    private var subscription: AnyCancellable?

    required init(presenter: EpisodeDetailsInteractorOutputProtocol, episodeService: EpisodeService) {
        self.presenter = presenter
        self.episodeService = episodeService
    }
    
    func provideEpisode(with id: Int) {
        subscription = episodeService.fetchEpisode(by: id)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveEpisode(model)
            })
    }
}
