//
//  LocationDetailsPresenter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

// MARK: - LocationDetails
struct LocationDetails {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let characterUrls: [String]
    let url: String
    let created: String
}

// MARK: - LocationDetailsPresenter
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
    
    func openCharacterList() {
        router.openCharacterListModule(with: location.characterUrls.compactMap {
            let id = $0.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
            return Int(id)
        })
    }
}

// MARK: - LocationDetailsPresenter + LocationDetailsInteractorOutputProtocol
extension LocationDetailsPresenter: LocationDetailsInteractorOutputProtocol {
    
    func receiveLocation(_ location: LocationModel) {
        self.location = LocationDetails(model: location)
        view?.setLocation(self.location)
    }
}

private extension LocationDetails {
    
    init(model: LocationModel) {
        self.id = model.id
        self.name = model.name
        self.type = model.type
        self.dimension = model.dimension
        self.characterUrls = model.residents
        self.url = model.url
        self.created = model.created
    }
}
