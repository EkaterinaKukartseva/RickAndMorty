//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 08.09.2021.
//

import Foundation

// MARK: - CharacterListInteractorInputProtocol
protocol CharacterListInteractorInputProtocol {
    
    /// Инициализация интерактора модуля `CharacterList`
    /// - Parameters:
    ///   - presenter: `CharacterListPresenter`
    ///   - characterService: `CharacterService`
    init(presenter: CharacterListInteractorOutputProtocol, characterService: CharacterService)
    
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
    private let characterService: CharacterService
    
    required init(presenter: CharacterListInteractorOutputProtocol, characterService: CharacterService) {
        self.presenter = presenter
        self.characterService = characterService
    }
    
    func provideCharacterList(with ids: [Int]) {
        characterService.fetchCharacters(by: ids) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacterList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    func provideAllCharacterList() {
        characterService.fetchCharacters { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacterList(model.results)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
