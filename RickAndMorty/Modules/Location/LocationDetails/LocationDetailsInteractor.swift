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
    
    func provideLocation(with url: String)
}

// MARK: - LocationDetailsInteractorOutputProtocol
protocol LocationDetailsInteractorOutputProtocol: AnyObject {
    
    func receiveLocation(_ location: LocationDetails)
}

// MARK: -
class LocationDetailsInteractor: LocationDetailsInteractorInputProtocol {
    
    unowned let presenter: LocationDetailsInteractorOutputProtocol
    
    required init(presenter: LocationDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideLocation(with url: String) {
        client.location().fetchLocation(byURL: url) { [unowned self] (result) in
            switch result {
            case .success(let model):
                let location = LocationDetails(id: model.id,
                                               name: model.name,
                                               type: model.type,
                                               dimension: model.dimension,
                                               characterUrls: model.residents,
                                               url: model.url,
                                               created: model.created)
                self.presenter.receiveLocation(location)
            case .failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
