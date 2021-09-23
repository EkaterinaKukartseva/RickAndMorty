//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

// MARK: - CharacterDetailsInteractorInputProtocol
protocol CharacterDetailsInteractorInputProtocol {
    
    init(presenter: CharacterDetailsInteractorOutputProtocol)
    
    /// Получить информацию о персонаже
    /// - Parameter id: id персонажа
    func provideCharacter(with id: Int)
}

// MARK: - CharacterInteractorOutputProtocol
protocol CharacterDetailsInteractorOutputProtocol: AnyObject {
    
    /// Получена информация о персонаже
    /// - Parameter location: модель персонажа
    func receiveCharacter(_ character: CharacterModel)
}

// MARK: - CharacterDetailsInteractor + CharacterDetailsInteractorInputProtocol
class CharacterDetailsInteractor: CharacterDetailsInteractorInputProtocol {
    
    private let presenter: CharacterDetailsInteractorOutputProtocol?
    
    required init(presenter: CharacterDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideCharacter(with id: Int) {
        client.character().fetchCharacter(byID: id) { (result) in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacter(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
