//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Foundation

struct EpisodeService {
    
    let networkManager: NetworkManager = NetworkManager()
    let client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Получение эпизода по ID
    func fetchEpisode(byID id: Int, completion: @escaping (Result<EpisodeModel, Error>) -> Void) {
        let path = Method.episode.rawValue + "\(id)"
        let urlString = networkManager.url(path: path)

        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: EpisodeModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Получение нескольких эпизодов по ID
    func fetchEpisodes(byID ids: [Int], completion: @escaping (Result<[EpisodeModel], Error>) -> Void) {

        let path = Method.episode.rawValue + ids.map({"\($0)"}).joined(separator: ",")
        let urlString = networkManager.url(path: path)

        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: [EpisodeModel] = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Получение эпизодов по номеру страницы
    func fetchEpisodes(byPageNumber pageNumber: Int, completion: @escaping (Result<InfoEpisodeModel, Error>) -> Void) {

        let path = Method.episodePage.rawValue + "\(pageNumber)"
        let urlString = networkManager.url(path: path)

        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: InfoEpisodeModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Получение всех эпизодов
    func fetchEpisodes(completion: @escaping (Result<EpisodeModel, Error>) -> Void) {
        let path = Method.episode.rawValue
        let urlString = networkManager.url(path: path)

        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: EpisodeModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение эпизодов по имени
    func fetchEpisodes(byName name: String, completion: @escaping (Result<InfoEpisodeModel, Error>) -> Void) {
        let path = Method.episode.rawValue + "?name=" + "\(name)"
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: InfoEpisodeModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
