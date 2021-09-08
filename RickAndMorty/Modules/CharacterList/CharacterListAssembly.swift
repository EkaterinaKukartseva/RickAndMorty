//
//  CharacterListAssembly.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 08.09.2021.
//

import Foundation

// MARK: - CharacterListAssemblyProtocol
protocol CharacterListAssemblyProtocol {
    
    func configure(with viewController: CharacterListViewController)
}

// MARK: - CharacterListAssembly + CharacterListAssemblyProtocol
class CharacterListAssembly: CharacterListAssemblyProtocol {
    
    func configure(with viewController: CharacterListViewController) {
        let presenter = CharacterListPresenter(view: viewController)
        let interactor = CharacterListInteractor(presenter: presenter)
        let router = CharacterListRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
