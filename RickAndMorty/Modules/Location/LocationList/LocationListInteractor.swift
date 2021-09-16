//
//  LocationListInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - LocationListInteractorInputProtocol
protocol LocationListInteractorInputProtocol: AnyObject {

    init(presenter: LocationListInteractorOutputProtocol)
    
    func provideAllLocationList()
}

// MARK: - LocationListInteractorOutputProtocol
protocol LocationListInteractorOutputProtocol {
    
    func receiveLocationList(_ list: [LocationModel])
}

// MARK: - LocationListInteractor
final class LocationListInteractor: LocationListInteractorInputProtocol {

    var presenter: LocationListInteractorOutputProtocol?

    required init(presenter: LocationListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideAllLocationList() {
        client.location().fetchLocations { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveLocationList(model.results)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
