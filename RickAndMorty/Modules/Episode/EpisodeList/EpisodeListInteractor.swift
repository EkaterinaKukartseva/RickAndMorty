//
//  EpisodeListInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 09/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation
import Combine

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
    private let episodeService: EpisodeServiceProtocol
    private var subscription: AnyCancellable?

    required init(presenter: EpisodeListInteractorOutputProtocol, episodeService: EpisodeService) {
        self.presenter = presenter
        self.episodeService = episodeService
    }
    
    func provideEpisodeList(with ids: [Int]) {
        subscription = episodeService.fetchEpisodes(by: ids)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveEpisodeList(model)
            })
    }
    
    func provideEpisodeList(with id: Int) {
        subscription = episodeService.fetchEpisode(by: id)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveEpisodeList(model)
            })
    }
}
