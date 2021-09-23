//
//  LocationDetailsInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

// MARK: - LocationDetailsInteractorInputProtocol
protocol LocationDetailsInteractorInputProtocol {
    
    init(presenter: LocationDetailsInteractorOutputProtocol)
    
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

// MARK: -
class LocationDetailsInteractor: LocationDetailsInteractorInputProtocol {
    
    private let presenter: LocationDetailsInteractorOutputProtocol?
    
    required init(presenter: LocationDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideLocation(with url: String) {
        client.location().fetchLocation(byURL: url) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.presenter?.receiveLocation(model)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
