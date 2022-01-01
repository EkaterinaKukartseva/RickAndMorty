//
//  CharacterAssembly.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

// MARK: - CharacterDetailsAssemblyProtocol
protocol CharacterDetailsAssemblyProtocol {
    
    /// Собрать модуль `CharacterDetails`
    func configure(with viewController: CharacterDetailsViewController)
}

// MARK: - CharacterDetailsAssembly + CharacterDetailsAssemblyProtocol
class CharacterDetailsAssembly: CharacterDetailsAssemblyProtocol {
    
    func configure(with viewController: CharacterDetailsViewController) {
        let presenter = CharacterDetailsPresenter(view: viewController)
        let interactor = CharacterDetailsInteractor(presenter: presenter,
                                                    characterService: CharacterService())
        let router = CharacterDetailsRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
