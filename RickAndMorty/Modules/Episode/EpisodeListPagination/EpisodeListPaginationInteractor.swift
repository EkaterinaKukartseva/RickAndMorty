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
