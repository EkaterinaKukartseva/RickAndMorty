//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Foundation
import Alamofire
import Combine
import OSLog

protocol CharacterServiceProtocol {
    
    /// Получить персонажа
    /// - Parameter id: id персонажа
    /// - Returns: Персонаж
    func fetchCharacter(by id: Int) -> AnyPublisher<CharacterModel, AFError>
    
    /// Получить список персонажей
    /// - Parameter ids: ids персонажей
    /// - Returns: Список персонажей
    func fetchCharacters(by ids: [Int]) -> AnyPublisher<[CharacterModel], AFError>
    
    /// Получить персонажа
    /// - Parameter page: Номер страницы
    /// - Returns: Список персонажей
    func fetchCharacters(by page: Int) -> AnyPublisher<InfoCharacterModel, AFError>
    
    /// Получить всех персонажей
    /// - Returns: Список персонажей
    func fetchCharacters() -> AnyPublisher<InfoCharacterModel, AFError>
}

/// Сервис персонажей
struct CharacterService: CharacterServiceProtocol {
    
    func fetchCharacter(by id: Int) -> AnyPublisher<CharacterModel, AFError> {
        return AF.request(Request.character("\(id)"))
            .publishDecodable(type: CharacterModel.self)
            .value()
    }
    
    func fetchCharacters(by ids: [Int]) -> AnyPublisher<[CharacterModel], AFError> {
        AF.request(Request.character(ids.map({"\($0)"}).joined(separator: ",")))
            .publishDecodable(type: [CharacterModel].self)
            .value()
    }
    
    func fetchCharacters(by page: Int) -> AnyPublisher<InfoCharacterModel, AFError> {
        AF.request(Request.characterPage("\(page)"))
            .publishDecodable(type: InfoCharacterModel.self)
            .value()
    }
    
    func fetchCharacters() -> AnyPublisher<InfoCharacterModel, AFError> {
        AF.request(Request.locationPage(""))
            .publishDecodable(type: InfoCharacterModel.self)
            .value()
    }
}
