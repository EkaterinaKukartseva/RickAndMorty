//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Foundation
import Alamofire

protocol CharacterServiceProtocol {
    
    func fetchCharacter(by id: Int, completion: @escaping (Result<CharacterModel, Error>) -> Void)
    func fetchCharacters(by ids: [Int], completion: @escaping (Result<[CharacterModel], Error>) -> Void)
    func fetchCharacters(by page: Int, completion: @escaping (Result<InfoCharacterModel, Error>) -> Void)
    func fetchCharacters(completion: @escaping (Result<InfoCharacterModel, Error>) -> Void)
}

struct CharacterService: CharacterServiceProtocol {
    
    /// Получение персонажей по ID
    func fetchCharacter(by id: Int, completion: @escaping (Result<CharacterModel, Error>) -> Void) {
        print("fetchCharacter(by id")
        AF.request("https://rickandmortyapi.com/api/character/\(id)")
            .responseDecodable(of: CharacterModel.self) { response in
                switch response.result {
                case .success(let characters):
                    completion(.success(characters))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    /// Получение нескольких персонажей по ID
    func fetchCharacters(by ids: [Int], completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        print("fetchCharacter(by ids")
        AF.request("https://rickandmortyapi.com/api/character/[\(ids.map({"\($0)"}).joined(separator: ","))]").responseDecodable(of: [CharacterModel].self) { response in
            switch response.result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение персонажей по номеру страницы
    func fetchCharacters(by page: Int, completion: @escaping (Result<InfoCharacterModel, Error>) -> Void) {
        print("fetchCharacter(by page")
        AF.request("https://rickandmortyapi.com/api/character/?page=\(page)").responseDecodable(of: InfoCharacterModel.self) { response in
            guard let infoCharacter = response.value else { fatalError() }
            completion(.success(infoCharacter))
        }
    }
    
    /// Получение всех персонажей 
    func fetchCharacters(completion: @escaping (Result<InfoCharacterModel, Error>) -> Void) {
        print("fetchCharacter")
        AF.request("https://rickandmortyapi.com/api/character/").responseDecodable(of: InfoCharacterModel.self) { response in
            guard let infoCharacter = response.value else { fatalError() }
            completion(.success(infoCharacter))
        }
    }
}
