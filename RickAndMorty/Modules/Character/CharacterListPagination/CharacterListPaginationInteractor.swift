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

    init(presenter: CharacterListPaginationInteractorOutputProtocol)
    
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

    required init(presenter: CharacterListPaginationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideCharacterList(by page: Int) {
        client.character().fetchCharacters(byPageNumber: page) { result in
            switch result {
            case .success(let model):
                self.presenter?.receiveCharacterList(model)
            case.failure(let error):
                print("ERROR \(error.localizedDescription)")
            }
        }
    }
}
