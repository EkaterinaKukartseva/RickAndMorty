//
//  LocationListPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

struct Location {
    
    let id: Int
    let name: String
    let dimension: String
}

// MARK: - LocationListPresenter
final class LocationListPresenter: LocationListViewOutputProtocol {

    private let view: LocationListViewInputProtocol?
    var interactor: LocationListInteractorInputProtocol!
    var router: LocationListRouterProtocol!
    
    required init(view: LocationListViewInputProtocol) {
        self.view = view
    }
    
    func showAllLocationList() {
        interactor.provideAllLocationList()
    }
}

// MARK: - LocationListPresenter + LocationListInteractorOutputProtocol
extension LocationListPresenter: LocationListInteractorOutputProtocol {
    
    func receiveLocationList(_ list: [LocationModel]) {
        view?.setLocationList(list.map({  Location(id: $0.id, name: $0.name, dimension: $0.dimension)}))
    }
}
