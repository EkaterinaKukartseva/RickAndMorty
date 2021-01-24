//
//  Location.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Foundation

struct Location {
    
    let networkManager: NetworkManager = NetworkManager()
    let client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Получение локации по ID
    func fetchLocation(byID id: Int, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        let path = Method.location.rawValue + "\(id)"
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: LocationModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение локации по URL
    func fetchLocation(byURL url: String, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        
        networkManager.performRequest(withURLString: url) { result in
            switch result {
            case .success(let data):
                if let model: LocationModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение нескольких локаций по ID
    func fetchLocations(byID ids: [Int], completion: @escaping (Result<[LocationModel], Error>) -> Void) {
        
        let path = Method.location.rawValue + ids.map({"\($0)"}).joined(separator: ",")
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: [LocationModel] = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение локации по номеру страницы
    func fetchLocations(byPageNumber pageNumber: Int, completion: @escaping (Result<InfoLocationModel, Error>) -> Void) {
        
        let path = Method.locationPage.rawValue + "\(pageNumber)"
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: InfoLocationModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Получение всех локаций
    func fetchLocations(completion: @escaping (Result<InfoLocationModel, Error>) -> Void) {
        let path = Method.location.rawValue
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { result in
            switch result {
            case .success(let data):
                if let model: InfoLocationModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLocations(byName name: String, completion: @escaping (Result<InfoLocationModel, Error>) -> Void) {
        let path = Method.location.rawValue + "?name=" + "\(name)"
        let urlString = networkManager.url(path: path)
        
        networkManager.performRequest(withURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                if let model: InfoLocationModel = self.networkManager.decodeJSONData(data: data) {
                    completion(.success(model))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
