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
    
    func showAllLocationList(by page: Int) {
        interactor.provideAllLocationList(by: page)
    }
    
    func showLocationDetails(with url: String) {
        router.openLocationDetails(with: url)
    }
}

// MARK: - LocationListPaginationPresenter + LocationListPaginationInteractorOutputProtocol
extension LocationListPaginationPresenter: LocationListPaginationInteractorOutputProtocol {
    
    func receiveLocationList(_ list: InfoLocationModel) {
        view?.setLocationList(.init(info: .init(count: list.info.count,
                                                pages: list.info.pages,
                                                next: list.info.next,
                                                prev: list.info.prev),
                                    results: list.results.map({ Location(id: $0.id,
                                                                         name: $0.name,
                                                                         dimension: $0.dimension,
                                                                         url: $0.url) })))
    }
}
