//
//  LocationDetailsAssembly.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 31.08.2021.
//

import Foundation

// MARK: - LocationDetailsAssemblyProtocol
protocol LocationDetailsAssemblyProtocol {
    
    /// Собрать модуль `Location`
    func configure(with viewController: LocationDetailsViewController)
}

// MARK: - LocationDetailsAssembly + LocationDetailsAssemblyProtocol
class LocationDetailsAssembly: LocationDetailsAssemblyProtocol {
    
    func configure(with viewController: LocationDetailsViewController) {
        let presenter = LocationDetailsPresenter(view: viewController)
        let interactor = LocationDetailsInteractor(presenter: presenter,
                                                   locationService: LocationService())
        let router = LocationDetailsRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
