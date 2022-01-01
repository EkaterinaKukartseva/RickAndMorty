//
//  LocationListPaginationInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - LocationListPaginationInteractorInputProtocol
protocol LocationListPaginationInteractorInputProtocol: AnyObject {

    /// Инициализация интерактора модуля `LocationListPagination`
    /// - Parameters:
    ///   - presenter: `LocationListPaginationPresenter`
    ///   - characterService: `LocationService`
    init(presenter: LocationListPaginationInteractorOutputProtocol, locationService: LocationService)
    
    /// Получить список локаций по странице
    /// - Parameter page: номер страницы
    func provideLocationList(by page: Int)
}

// MARK: - LocationListPaginationInteractorOutputProtocol
protocol LocationListPaginationInteractorOutputProtocol {
    
    /// Получена информация о странцице  с локациями
    /// - Parameter info: инфо страницы
    func receiveLocationList(_ info: InfoLocationModel)
}

// MARK: - LocationListPaginationInteractor
final class LocationListPaginationInteractor: LocationListPaginationInteractorInputProtocol {

    private let presenter: LocationListPaginationInteractorOutputProtocol?
    private let locationService: LocationService

    required init(presenter: LocationListPaginationInteractorOutputProtocol, locationService: LocationService) {
        self.presenter = presenter
        self.locationService = locationService
    }
    
    func provideLocationList(by page: Int) {
        locationService.fetchLocations(by: page) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveLocationList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
