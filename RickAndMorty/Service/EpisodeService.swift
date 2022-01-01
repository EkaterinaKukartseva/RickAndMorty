//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Alamofire
import Foundation

struct EpisodeService {
    
    /// Получение эпизода по ID
    func fetchEpisode(by id: Int, completion: @escaping (Result<EpisodeModel, Error>) -> Void) {
        print("fetchEpisode(by id")
        AF.request(Request.episode("\(id)"))
            .responseDecodable(of: EpisodeModel.self) { response in
                switch response.result {
                case .success(let episodeModel):
                    completion(.success(episodeModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    /// Получение нескольких эпизодов по ID
    func fetchEpisodes(by ids: [Int], completion: @escaping (Result<[EpisodeModel], Error>) -> Void) {
        print("fetchEpisode(by ids")
        AF.request(Request.episode(ids.map({"\($0)"}).joined(separator: ",")))
            .responseDecodable(of: [EpisodeModel].self) { response in
                switch response.result {
                case .success(let episodeModels):
                    completion(.success(episodeModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    /// Получение эпизодов по номеру страницы
    func fetchEpisodes(by pageNumber: Int, completion: @escaping (Result<InfoEpisodeModel, Error>) -> Void) {
        print("fetchEpisode(by page")
        AF.request(Request.episodePage("\(pageNumber)"))
            .responseDecodable(of: InfoEpisodeModel.self) { response in
                switch response.result {
                case .success(let episodeModel):
                    completion(.success(episodeModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    /// Получение всех эпизодов
//    func fetchEpisodes(completion: @escaping (Result<InfoEpisodeModel, Error>) -> Void) {
//        let path = Method.episode.rawValue
//        let urlString = networkManager.url(path: path)
//
//        networkManager.performRequest(withURLString: urlString) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    if let model: InfoEpisodeModel = self.networkManager.decodeJSONData(data: data) {
//                        completion(.success(model))
//                    }
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    /// Получение эпизодов по имени
//    func fetchEpisodes(byName name: String, completion: @escaping (Result<InfoEpisodeModel, Error>) -> Void) {
//        let path = Method.episode.rawValue + "?name=" + "\(name)"
//        let urlString = networkManager.url(path: path)
//
//        networkManager.performRequest(withURLString: urlString) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    if let model: InfoEpisodeModel = self.networkManager.decodeJSONData(data: data) {
//                        completion(.success(model))
//                    }
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
