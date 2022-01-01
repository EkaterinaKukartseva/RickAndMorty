//
//  CharacterListPaginationInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - CharacterListPaginationInteractorInputProtocol
protocol CharacterListPaginationInteractorInputProtocol: AnyObject {

    /// Инициализация интерактора модуля `CharacterList`
    /// - Parameters:
    ///   - presenter: `CharacterListPaginationPresenter`
    ///   - characterService: `CharacterService`
    init(presenter: CharacterListPaginationInteractorOutputProtocol, characterService: CharacterService)
    
    /// Получить список персонажей по страницам
    /// - Parameter page: номер страницы
    func provideCharacterList(by page: Int)
}

// MARK: - CharacterListPaginationInteractorOutputProtocol
protocol CharacterListPaginationInteractorOutputProtocol {
    
    /// Получена информация о странцице с персонажами
    /// - Parameter model: инфо страницы
    func receiveCharacterList(_ list: InfoCharacterModel)
}

// MARK: - CharacterListPaginationInteractor
final class CharacterListPaginationInteractor: CharacterListPaginationInteractorInputProtocol {

    private let presenter: CharacterListPaginationInteractorOutputProtocol?
    private let characterService: CharacterService

    required init(presenter: CharacterListPaginationInteractorOutputProtocol, characterService: CharacterService) {
        self.presenter = presenter
        self.characterService = characterService
    }
    
    func provideCharacterList(by page: Int) {
        characterService.fetchCharacters(by: page) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacterList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
