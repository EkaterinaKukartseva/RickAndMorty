//
//  LocationService.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 20.12.2020.
//

import Alamofire
import Foundation
import Combine

protocol LocationServiceProtocol {
    
    /// Получить локацию
    /// - Parameter url: url локации
    /// - Returns: Локация
    func fetchLocation(by url: String) -> AnyPublisher<LocationModel, AFError>
    
    /// Получить список локаций
    /// - Parameter page: Номер страницы
    /// - Returns: Список локаций
    func fetchLocations(by page: Int) -> AnyPublisher<InfoLocationModel, AFError>
}

/// Сервис локаций
struct LocationService: LocationServiceProtocol {
    
    func fetchLocation(by url: String) -> AnyPublisher<LocationModel, AFError> {
        AF.request(url)
            .publishDecodable(type: LocationModel.self)
            .value()
    }
    
    func fetchLocations(by page: Int) -> AnyPublisher<InfoLocationModel, AFError> {
        AF.request(Request.locationPage("\(page)"))
            .publishDecodable(type: InfoLocationModel.self)
            .value()
    }
}
