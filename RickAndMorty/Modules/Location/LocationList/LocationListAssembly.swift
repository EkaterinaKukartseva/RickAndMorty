//
//  LocationListAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - LocationListAssemblyProtocol
protocol LocationListAssemblyProtocol {
    
    func configure(with viewController: LocationListViewController)
}

// MARK: - LocationListAssembly + LocationListAssemblyProtocol
class LocationListAssembly: LocationListAssemblyProtocol {
    
    func configure(with viewController: LocationListViewController) {
        let presenter = LocationListPresenter(view: viewController)
        let interactor = LocationListInteractor(presenter: presenter)
        let router = LocationListRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
