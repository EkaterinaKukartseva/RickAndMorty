//
//  CharacterListPaginationAssembly.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - CharacterListPaginationAssemblyProtocol
protocol CharacterListPaginationAssemblyProtocol {
    
    /// Собрать модуль `CharacterListPagination`
    func configure(with viewController: CharacterListPaginationViewController)
}

// MARK: - CharacterListPaginationAssembly + CharacterListPaginationAssemblyProtocol
class CharacterListPaginationAssembly: CharacterListPaginationAssemblyProtocol {
    
    func configure(with viewController: CharacterListPaginationViewController) {
        let presenter = CharacterListPaginationPresenter(view: viewController)
        let interactor = CharacterListPaginationInteractor(presenter: presenter,
                                                           characterService: CharacterService())
        let router = CharacterListPaginationRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
