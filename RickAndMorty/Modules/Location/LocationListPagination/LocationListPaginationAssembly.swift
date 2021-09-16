//
//  LocationListPaginationAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - LocationListPaginationAssemblyProtocol
protocol LocationListPaginationAssemblyProtocol {
    
    func configure(with viewController: LocationListPaginationViewController)
}

// MARK: - LocationListPaginationAssembly + LocationListPaginationAssemblyProtocol
class LocationListPaginationAssembly: LocationListPaginationAssemblyProtocol {
    
    func configure(with viewController: LocationListPaginationViewController) {
        let presenter = LocationListPaginationPresenter(view: viewController)
        let interactor = LocationListPaginationInteractor(presenter: presenter)
        let router = LocationListPaginationRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
