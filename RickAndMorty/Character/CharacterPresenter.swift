//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

// MARK: - CharacterData
struct CharacterData {
    
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginModel
    let location: CharacterLocationModel
    let image: String
}

// MARK: - CharacterPresenter
class CharacterPresenter: CharacterViewOutputProtocol {
    
    unowned let view: CharacterViewInputProtocol
    var interactor: CharacterInteractorInputProtocol!
    
    required init(view: CharacterViewInputProtocol) {
        self.view = view
    }
    
    func didTabShowCharacter() {
        interactor.provideCharacterData()
    }
}

// MARK: - CharacterPresenter + CharacterInteractorOutputProtocol
extension CharacterPresenter: CharacterInteractorOutputProtocol {
    
    func receiveCharacterData(characterData: CharacterData) {
        view.setCharacter(characterData)
    }
}
