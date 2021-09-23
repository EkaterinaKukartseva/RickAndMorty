//
//  LocationListPaginationPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - InfoLocation
struct InfoLocation {
    
    let info: Info
    let results: [Location]
}

// MARK: - Location
struct Location {
    
    let id: Int
    let name: String
    let dimension: String
    let url: String
}

// MARK: - LocationListPaginationPresenter
final class LocationListPaginationPresenter: LocationListPaginationViewOutputProtocol {

    private let view: LocationListPaginationViewInputProtocol?
    var interactor: LocationListPaginationInteractorInputProtocol!
    var router: LocationListPaginationRouterProtocol!
    
    required init(view: LocationListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showLocationList(by page: Int) {
        interactor.provideLocationList(by: page)
    }
    
    func openLocationDetails(with url: String) {
        router.openLocationDetailsModule(with: url)
    }
}

// MARK: - LocationListPaginationPresenter + LocationListPaginationInteractorOutputProtocol
extension LocationListPaginationPresenter: LocationListPaginationInteractorOutputProtocol {
    
    func receiveLocationList(_ model: InfoLocationModel) {
        view?.setLocationList(.init(model: model))
    }
}

// MARK: - InfoLocation private
private extension InfoLocation {
    
    init(model: InfoLocationModel) {
        self.info = .init(info: model.info)
        self.results = model.results.map { .init(model: $0) }
    }
}

// MARK: - Location private
private extension Location {
    
    init(model: LocationModel) {
        self.id = model.id
        self.url = model.url
        self.name = model.name
        self.dimension = model.dimension
    }
}
