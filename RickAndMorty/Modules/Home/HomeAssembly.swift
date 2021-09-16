//
//  HomeAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 14/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - HomeAssemblyProtocol
protocol HomeAssemblyProtocol {
    
    func configure(with viewController: HomeViewController)
}

// MARK: - HomeAssembly + HomeAssemblyProtocol
class HomeAssembly: HomeAssemblyProtocol {
    
    func configure(with viewController: HomeViewController) {
        let presenter = HomePresenter(view: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        let router = HomeRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
