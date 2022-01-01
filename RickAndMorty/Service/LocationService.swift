//
//  LocationService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Alamofire
import Foundation

struct LocationService {
    
    /// Получение локации по ID
    func fetchLocation(by id: Int, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        print("fetchLocation(by id")
        AF.request(Request.location("\(id)"))
            .responseDecodable(of: LocationModel.self) { response in
                switch response.result {
                case .success(let locationModel):
                    completion(.success(locationModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Получение локации по URL
    func fetchLocation(by url: String, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        AF.request(url)
            .responseDecodable(of: LocationModel.self) { response in
                switch response.result {
                case .success(let locationModel):
                    completion(.success(locationModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Получение нескольких локаций по ID
    func fetchLocations(by ids: [Int], completion: @escaping (Result<[LocationModel], Error>) -> Void) {
        print("fetchLocation(by ids")
        AF.request(Request.location(ids.map({"\($0)"}).joined(separator: ",")))
            .responseDecodable(of: [LocationModel].self) { response in
                switch response.result {
                case .success(let locationModels):
                    completion(.success(locationModels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Получение локации по номеру страницы
    func fetchLocations(by page: Int, completion: @escaping (Result<InfoLocationModel, Error>) -> Void) {
        print("fetchLocation(by page")
        print("\(Request.locationPage("\(page)"))")
        AF.request(Request.locationPage("\(page)"))
            .responseDecodable(of: InfoLocationModel.self) { response in
                switch response.result {
                case .success(let locationModel):
                    completion(.success(locationModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    /// Получение всех локаций
//    func fetchLocations(completion: @escaping (Result<InfoLocationModel, Error>) -> Void) {
//        let path = Method.location.rawValue
//        let urlString = networkManager.url(path: path)
//        
//        networkManager.performRequest(withURLString: urlString) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    if let model: InfoLocationModel = self.networkManager.decodeJSONData(data: data) {
//                        completion(.success(model))
//                    }
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    func fetchLocations(byName name: String, completion: @escaping (Result<InfoLocationModel, Error>) -> Void) {
//        let path = Method.location.rawValue + "?name=" + "\(name)"
//        let urlString = networkManager.url(path: path)
//        
//        networkManager.performRequest(withURLString: urlString) { (result) in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    if let model: InfoLocationModel = self.networkManager.decodeJSONData(data: data) {
//                        completion(.success(model))
//                    }
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
