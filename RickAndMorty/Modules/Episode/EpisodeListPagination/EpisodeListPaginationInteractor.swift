//
//  EpisodeListPaginationInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation
import Combine

// MARK: - EpisodeListPaginationInteractorInputProtocol
protocol EpisodeListPaginationInteractorInputProtocol: AnyObject {

    /// Инициализация интерактора модуля `EpisodeListPagination`
    /// - Parameters:
    ///   - presenter: `EpisodeListPaginationPresenter`
    ///   - characterService: `EpisodeService`
    init(presenter: EpisodeListPaginationInteractorOutputProtocol, episodeService: EpisodeService)
    
    /// Получить список серий по страницам
    /// - Parameter page: номер страницы
    func provideEpisodeList(by page: Int)
}

// MARK: - EpisodeListPaginationInteractorOutputProtocol
protocol EpisodeListPaginationInteractorOutputProtocol {
    
    /// Получена информация о странцице с сериями
    /// - Parameter model: инфо страницы
    func receiveEpisodeList(_ model: InfoEpisodeModel)
}

// MARK: - EpisodeListPaginationInteractor
final class EpisodeListPaginationInteractor: EpisodeListPaginationInteractorInputProtocol {

    private let presenter: EpisodeListPaginationInteractorOutputProtocol?
    private let episodeService: EpisodeServiceProtocol
    private var subscription: AnyCancellable?

    required init(presenter: EpisodeListPaginationInteractorOutputProtocol, episodeService: EpisodeService) {
        self.presenter = presenter
        self.episodeService = episodeService
    }
    
    func provideEpisodeList(by page: Int) {
        subscription = episodeService.fetchEpisodes(by: page)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveEpisodeList(model)
            })
    }
}
