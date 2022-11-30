//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Alamofire
import Foundation
import Combine

protocol EpisodeServiceProtocol {
    
    /// Получить серию
    /// - Parameter id: id серии
    /// - Returns: Серия
    func fetchEpisode(by id: Int) -> AnyPublisher<EpisodeModel, AFError>
    
    /// Получить список серий
    /// - Parameter ids: ids серий
    /// - Returns: Список серий
    func fetchEpisodes(by ids: [Int]) -> AnyPublisher<[EpisodeModel], AFError>
    
    /// Получить список серий
    /// - Parameter page: Номер страницы
    /// - Returns: Список серий
    func fetchEpisodes(by page: Int) -> AnyPublisher<InfoEpisodeModel, AFError>
}

/// Сервис серий
struct EpisodeService: EpisodeServiceProtocol {
    
    func fetchEpisode(by id: Int) -> AnyPublisher<EpisodeModel, AFError> {
        AF.request(Request.episode("\(id)"))
            .publishDecodable(type: EpisodeModel.self)
            .value()
    }
    
    func fetchEpisodes(by ids: [Int]) -> AnyPublisher<[EpisodeModel], AFError> {
        AF.request(Request.episode(ids.map({"\($0)"}).joined(separator: ",")))
            .publishDecodable(type: [EpisodeModel].self)
            .value()
    }
    
    func fetchEpisodes(by page: Int) -> AnyPublisher<InfoEpisodeModel, AFError> {
        AF.request(Request.episodePage("\(page)"))
            .publishDecodable(type: InfoEpisodeModel.self)
            .value()
    }
}
