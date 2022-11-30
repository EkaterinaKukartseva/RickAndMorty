//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 30.08.2021.
//

import Foundation
import Combine

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
    private let characterService: CharacterServiceProtocol
    private var subscription: AnyCancellable?
    
    required init(presenter: CharacterDetailsInteractorOutputProtocol, characterService: CharacterService) {
        self.presenter = presenter
        self.characterService = characterService
    }
    
    func provideCharacter(with id: Int) {
        subscription = characterService.fetchCharacter(by: id)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveCharacter(model)
            })
    }
}
