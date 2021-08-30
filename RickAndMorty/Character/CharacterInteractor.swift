//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

// MARK: - CharacterInteractorInputProtocol
protocol CharacterInteractorInputProtocol {
    
    init(presenter: CharacterInteractorOutputProtocol)
    
    func provideCharacterData()
}

// MARK: - CharacterInteractorOutputProtocol
protocol CharacterInteractorOutputProtocol: AnyObject {
    
    func receiveCharacterData(characterData: CharacterData)
}

// MARK: - CharacterInteractor + CharacterInteractorInputProtocol
class CharacterInteractor: CharacterInteractorInputProtocol {
    
    unowned let presenter: CharacterInteractorOutputProtocol
    
    required init(presenter: CharacterInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideCharacterData() {
        client.character().fetchCharacter(byID: 1) { (result) in
            switch result {
            case .success(let model):
                let character = CharacterData(name: model.name,
                                              status: model.status,
                                              species: model.species,
                                              type: model.type,
                                              gender: model.gender,
                                              origin: model.origin,
                                              location: model.location,
                                              image: model.image)
                self.presenter.receiveCharacterData(characterData: character)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
