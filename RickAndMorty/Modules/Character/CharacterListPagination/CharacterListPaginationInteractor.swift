//
//  CharacterListPaginationInteractor.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation
import Combine

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
    private let characterService: CharacterServiceProtocol
    private var subscription: AnyCancellable?

    required init(presenter: CharacterListPaginationInteractorOutputProtocol, characterService: CharacterService) {
        self.presenter = presenter
        self.characterService = characterService
    }
    
    func provideCharacterList(by page: Int) {
        subscription = characterService.fetchCharacters(by: page)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] model in
                guard let self = self else { return }
                self.presenter?.receiveCharacterList(model)
            })
    }
}
