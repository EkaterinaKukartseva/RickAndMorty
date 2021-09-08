//
//  LocationDetailsPresenter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

// MARK: -
struct LocationDetails {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let characterUrls: [String]
    let url: String
    let created: String
}

// MARK: -
class LocationDetailsPresenter: LocationDetailsViewOutputProtocol {

    unowned let view: LocationDetailsViewInputProtocol
    var interactor: LocationDetailsInteractorInputProtocol!
    var router: LocationDetailsRouterProtocol!
    
    private var location: LocationDetails!
    
    required init(view: LocationDetailsViewInputProtocol) {
        self.view = view
    }
    
    func didTabShowLocation(with url: String) {
        interactor.provideLocation(with: url)
    }
    
    func showCharacterList() {
        router.openCharacterList(with: location.characterUrls)
    }
}

extension LocationDetailsPresenter: LocationDetailsInteractorOutputProtocol {
    
    func receiveLocation(_ location: LocationDetails) {
        self.location = location
        view.setLocation(location)
    }
}
