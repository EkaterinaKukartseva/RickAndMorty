//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 08.09.2021.
//

import Foundation
import Combine

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
    private let characterService: CharacterServiceProtocol
    private var subscriptions: AnyCancellable?
    
    required init(presenter: CharacterListInteractorOutputProtocol, characterService: CharacterService) {
        self.presenter = presenter
        self.characterService = characterService
    }
    
    func provideCharacterList(with ids: [Int]) {
        subscriptions = characterService.fetchCharacters(by: ids)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveCharacterList(model)
            })
    }
    
    func provideAllCharacterList() {
        subscriptions = characterService.fetchCharacters()
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveCharacterList(model.results)
            })
    }
}
