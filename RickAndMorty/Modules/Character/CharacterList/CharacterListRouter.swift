//
//  CharacterListRouter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 08.09.2021.
//

import Foundation

// MARK: - CharacterListRouterProtocol
protocol CharacterListRouterProtocol {
    
    init(viewController: CharacterListViewController)
    
    /// Открыть экран с детальной информацией о персонаже
    /// - Parameter id: id персонажа
    func openCharacterDetailsModule(with id: Int)
}

// MARK: - CharacterListRouter + CharacterListRouterProtocol
class CharacterListRouter: CharacterListRouterProtocol {

    private let viewController: CharacterListViewController?
    
    required init(viewController: CharacterListViewController) {
        self.viewController = viewController
    }
    
    func openCharacterDetailsModule(with id: Int) {
        viewController?.performSegue(withIdentifier: "showResident", sender: id)
    }
}
