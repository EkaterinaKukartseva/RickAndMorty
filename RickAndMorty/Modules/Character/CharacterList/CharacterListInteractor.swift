//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 08.09.2021.
//

import Foundation

// MARK: - CharacterListInteractorInputProtocol
protocol CharacterListInteractorInputProtocol {
    
    init(presenter: CharacterListInteractorOutputProtocol)
    
    func provideCharacterList(with ids: [Int])
}

// MARK: - CharacterListInteractorOutputProtocol
protocol CharacterListInteractorOutputProtocol: AnyObject {
    
    func receiveCharacterList(_ list: [Character])
}

// MARK: - CharacterListInteractor + CharacterListInteractorInputProtocol
class CharacterListInteractor: CharacterListInteractorInputProtocol {
    
    unowned let presenter: CharacterListInteractorOutputProtocol
    
    required init(presenter: CharacterListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideCharacterList(with ids: [Int]) {
        client.character().fetchCharacters(byID: ids) { result in
            switch result {
            case .success(let model):
                self.presenter.receiveCharacterList(model.map({
                    Character(id: $0.id, name: $0.name, image: $0.image, status: $0.status, gender: $0.gender)
                }))
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    func provideAllCharacterList() {
        client.character().fetchAllCharacters { result in
            switch result {
            case .success(let model):
                self.presenter.receiveCharacterList(model.results.map({
                    Character(id: $0.id, name: $0.name, image: $0.image, status: $0.status, gender: $0.gender)
                }))
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
