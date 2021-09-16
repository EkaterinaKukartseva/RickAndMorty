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

    init(presenter: LocationListPaginationInteractorOutputProtocol)
    
    func provideAllLocationList(by page: Int)
}

// MARK: - LocationListPaginationInteractorOutputProtocol
protocol LocationListPaginationInteractorOutputProtocol {
    
    func receiveLocationList(_ list: InfoLocationModel)
}

// MARK: - LocationListPaginationInteractor
final class LocationListPaginationInteractor: LocationListPaginationInteractorInputProtocol {

    var presenter: LocationListPaginationInteractorOutputProtocol?

    required init(presenter: LocationListPaginationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideAllLocationList(by page: Int) {
        client.location().fetchLocations(byPageNumber: page) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveLocationList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
