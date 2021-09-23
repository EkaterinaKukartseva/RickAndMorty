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
    
    /// Получить список персонажей
    /// - Parameter ids: ids персонажей
    func provideCharacterList(with ids: [Int])
}

// MARK: - CharacterListInteractorOutputProtocol
protocol CharacterListInteractorOutputProtocol: AnyObject {
    
    /// Получен список персонажей
    /// - Parameter list: список персонажей
    func receiveCharacterList(_ list: [CharacterModel])
}

// MARK: - CharacterListInteractor + CharacterListInteractorInputProtocol
class CharacterListInteractor: CharacterListInteractorInputProtocol {
    
    private let presenter: CharacterListInteractorOutputProtocol?
    
    required init(presenter: CharacterListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideCharacterList(with ids: [Int]) {
        client.character().fetchCharacters(byID: ids) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacterList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    func provideAllCharacterList() {
        client.character().fetchAllCharacters { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacterList(model.results)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
