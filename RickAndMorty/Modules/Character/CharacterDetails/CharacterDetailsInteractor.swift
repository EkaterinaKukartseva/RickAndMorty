//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation

// MARK: - CharacterDetailsInteractorInputProtocol
protocol CharacterDetailsInteractorInputProtocol {
    
    /// Инициализация интерактора модуля `CharacterList`
    /// - Parameters:
    ///   - presenter: `CharacterDetails`
    ///   - characterService: `CharacterService`
    init(presenter: CharacterDetailsInteractorOutputProtocol, characterService: CharacterService)
    
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
    private let characterService: CharacterService
    
    required init(presenter: CharacterDetailsInteractorOutputProtocol, characterService: CharacterService) {
        self.presenter = presenter
        self.characterService = characterService
    }
    
    func provideCharacter(with id: Int) {
        characterService.fetchCharacter(by: id) { (result) in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacter(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
