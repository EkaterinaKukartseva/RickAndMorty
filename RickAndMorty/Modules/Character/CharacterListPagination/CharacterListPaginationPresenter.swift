//
//  CharacterListPaginationPresenter.swift
//  RickAndMorty
//
//  Created by Ekaterina Kukartseva on 16/09/2021.
//  Copyright © 2021 Ekaterina Kukartseva. All rights reserved.
//

import Foundation

// MARK: - InfoCharacter
struct InfoCharacter {
    
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

extension Info {
    
    init(info: InfoModel) {
        self.count = info.count
        self.pages = info.pages
        self.next = info.next
        self.prev = info.next
    }
}

// MARK: - CharacterListPaginationPresenter
final class CharacterListPaginationPresenter: CharacterListPaginationViewOutputProtocol {

    private let view: CharacterListPaginationViewInputProtocol?
    var interactor: CharacterListPaginationInteractorInputProtocol!
    var router: CharacterListPaginationRouterProtocol!
    
    required init(view: CharacterListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showAllCharacterList(by page: Int) {
        interactor.provideCharacterList(by: page)
    }
    
    func showCharacterDetails(with id: Int) {
        router.openCharacterDetailsModule(with: id)
    }
}

// MARK: - CharacterListPaginationPresenter + CharacterListPaginationInteractorOutputProtocol
extension CharacterListPaginationPresenter: CharacterListPaginationInteractorOutputProtocol {
    
    func receiveCharacterList(_ list: InfoCharacterModel) {
        view?.setCharacterList(InfoCharacter(model: list))
    }
}

// MARK: - InfoLocation private
private extension InfoCharacter {
    
    init(model: InfoCharacterModel) {
        self.info = .init(info: model.info)
        self.results = model.results.map { .init(model: $0) }
    }
}

// MARK: - Location private
private extension Character {
    
    init(model: CharacterModel) {
        self.id = model.id
        self.name = model.name
        self.image = model.image
        self.gender = model.gender
        self.status = model.status
    }
}
