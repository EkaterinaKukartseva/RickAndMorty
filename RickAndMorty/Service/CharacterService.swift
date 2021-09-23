//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Foundation

struct CharacterService {
    
    public init(client: Client) {
        self.client = client
    }
    
    let networkManager: NetworkManager = NetworkManager()
    let client: Client
    
    /// Получение персонажей по ID
    func fetchCharacter(byID id: Int, completion: @escaping (Result<CharacterModel, Error>) -> Void) {
        let path = Method.character.rawValue + "\(id)"
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let model: CharacterModel = self.networkManager.decodeJSONData(data: data) {
                        completion(.success(model))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение нескольких персонажей по ID
    func fetchCharacters(byID ids: [Int], completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        
        let path = Method.character.rawValue + ids.map({"\($0)"}).joined(separator: ",")
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let model: [CharacterModel] = self.networkManager.decodeJSONData(data: data) {
                        completion(.success(model))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение персонажей по номеру страницы
    func fetchCharacters(byPageNumber pageNumber: Int, completion: @escaping (Result<InfoCharacterModel, Error>) -> Void) {
        
        let path = Method.characterPage.rawValue + "\(pageNumber)"
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let model: InfoCharacterModel = self.networkManager.decodeJSONData(data: data) {
                        completion(.success(model))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение всех персонажей 
    func fetchAllCharacters(completion: @escaping (Result<InfoCharacterModel, Error>) -> Void) {
        let path = Method.character.rawValue
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let model: InfoCharacterModel = self.networkManager.decodeJSONData(data: data) {
                        completion(.success(model))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCharacters(byName name: String, completion: @escaping (Result<InfoCharacterModel, Error>) -> Void) {
        
        let path = Method.character.rawValue + "?name=" + "\(name)"
        let urlString = networkManager.url(path: path)
        
        print(urlString)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let model: InfoCharacterModel = self.networkManager.decodeJSONData(data: data) {
                        completion(.success(model))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
