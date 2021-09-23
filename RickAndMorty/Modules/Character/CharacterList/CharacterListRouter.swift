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
    
    func openCharacterDetails(with id: Int)
}

// MARK: - CharacterListRouter + CharacterListRouterProtocol
class CharacterListRouter: CharacterListRouterProtocol {

    private let viewController: CharacterListViewController?
    
    required init(viewController: CharacterListViewController) {
        self.viewController = viewController
    }
    
    func openCharacterDetails(with id: Int) {
        viewController?.performSegue(withIdentifier: "showResident", sender: id)
    }
}
