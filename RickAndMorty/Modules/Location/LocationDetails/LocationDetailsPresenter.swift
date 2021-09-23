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

    private let view: LocationDetailsViewInputProtocol?
    var interactor: LocationDetailsInteractorInputProtocol!
    var router: LocationDetailsRouterProtocol!
    
    private var location: LocationDetails!
    
    required init(view: LocationDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showLocation(with url: String) {
        interactor.provideLocation(with: url)
    }
    
    func openCharacterListModule() {
        router.openCharacterList(with: location.characterUrls.compactMap {
            let id = $0.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
            return Int(id)
        })
    }
}

extension LocationDetailsPresenter: LocationDetailsInteractorOutputProtocol {
    
    func receiveLocation(_ location: LocationDetails) {
        self.location = location
        view?.setLocation(location)
    }
}
