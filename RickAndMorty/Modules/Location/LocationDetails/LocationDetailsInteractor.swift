//
//  LocationDetailsInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

// MARK: - LocationDetailsInteractorInputProtocol
protocol LocationDetailsInteractorInputProtocol {
    
    /// Инициализация интерактора модуля `LocationDetails`
    /// - Parameters:
    ///   - presenter: `LocationDetailsPresenter`
    ///   - characterService: `LocationService`
    init(presenter: LocationDetailsInteractorOutputProtocol, locationService: LocationService)
    
    /// Получить информацию о локации
    /// - Parameter url: url локации
    func provideLocation(with url: String)
}

// MARK: - LocationDetailsInteractorOutputProtocol
protocol LocationDetailsInteractorOutputProtocol: AnyObject {
    
    /// Получена информация о локации
    /// - Parameter location: модель локации
    func receiveLocation(_ location: LocationModel)
}

// MARK: - LocationDetailsInteractor
class LocationDetailsInteractor: LocationDetailsInteractorInputProtocol {
    
    private let presenter: LocationDetailsInteractorOutputProtocol?
    private let locationService: LocationService
    
    required init(presenter: LocationDetailsInteractorOutputProtocol, locationService: LocationService) {
        self.presenter = presenter
        self.locationService = locationService
    }
    
    func provideLocation(with url: String) {
        locationService.fetchLocation(by: url) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.presenter?.receiveLocation(model)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
