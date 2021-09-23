//
//  CharacterListPaginationRouter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - CharacterListPaginationRouterProtocol
protocol CharacterListPaginationRouterProtocol {
    
    init(viewController: CharacterListPaginationViewController)
    
    /// Открыть экран с детальной информацией о персонаже
    /// - Parameter id: id персонажа
    func openCharacterDetailsModule(with id: Int)
}

// MARK: - CharacterListPaginationRouter + CharacterListPaginationRouterProtocol
final class CharacterListPaginationRouter: CharacterListPaginationRouterProtocol {
    
    private let viewController: CharacterListPaginationViewController?
    
    required init(viewController: CharacterListPaginationViewController) {
        self.viewController = viewController
    }
    
    func openCharacterDetailsModule(with id: Int) {
        viewController?.performSegue(withIdentifier: "showResident", sender: id)
    }
}
