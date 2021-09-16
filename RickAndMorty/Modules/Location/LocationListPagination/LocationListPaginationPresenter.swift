//
//  LocationListPaginationPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - Location
struct Location {
    
    let id: Int
    let name: String
    let dimension: String
}

// MARK: - LocationListPaginationPresenter
final class LocationListPaginationPresenter: LocationListPaginationViewOutputProtocol {

    private let view: LocationListPaginationViewInputProtocol?
    var interactor: LocationListPaginationInteractorInputProtocol!
    var router: LocationListPaginationRouterProtocol!
    
    required init(view: LocationListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showAllLocationList() {
        interactor.provideAllLocationList()
    }
}

// MARK: - LocationListPaginationPresenter + LocationListPaginationInteractorOutputProtocol
extension LocationListPaginationPresenter: LocationListPaginationInteractorOutputProtocol {
    
    func receiveLocationList(_ list: [LocationModel]) {
        view?.setLocationList(list.map({  Location(id: $0.id, name: $0.name, dimension: $0.dimension)}))
    }
}
