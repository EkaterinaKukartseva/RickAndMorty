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
    
    private var currentPage = 1
    private var info: Info!
    private var isNextPageAvailable = true
    
    required init(view: LocationListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showLocationList() {
        interactor.provideLocationList(by: currentPage)
    }
    
    func showLocationListNextPage() {
        guard isNextPageAvailable else { return }
        view?.setPageLoading(with: true)
        currentPage += 1
        interactor.provideLocationList(by: currentPage)
    }
    
    func openLocationDetails(with url: String) {
        router.openLocationDetailsModule(with: url)
    }
}

// MARK: - LocationListPaginationPresenter + LocationListPaginationInteractorOutputProtocol
extension LocationListPaginationPresenter: LocationListPaginationInteractorOutputProtocol {
    
    func receiveLocationList(_ model: InfoLocationModel) {
        self.info = Info(info: model.info)
        isNextPageAvailable = info.next != nil
        view?.setLocationList(model.results.map { .init($0) }, isNextPage: info.prev != nil)
    }
}

// MARK: - Location private
private extension Location {
    
    init(_ model: LocationModel) {
        self.id = model.id
        self.url = model.url
        self.name = model.name
        self.dimension = model.dimension
    }
}
