//
//  LocationDetailsInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation
import Combine

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
    private let locationService: LocationServiceProtocol
    private var subscription: AnyCancellable?
    
    required init(presenter: LocationDetailsInteractorOutputProtocol, locationService: LocationService) {
        self.presenter = presenter
        self.locationService = locationService
    }
    
    func provideLocation(with url: String) {
        subscription = locationService.fetchLocation(by: url)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveLocation(model)
            })
    }
}
