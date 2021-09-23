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
        view?.setCharacterList(.init(info: .init(count: list.info.count, pages: list.info.pages, next: list.info.next, prev: list.info.prev),
                                     results: list.results.map({ Character(id: $0.id, name: $0.name, image: $0.image, status: $0.status, gender: $0.gender) })))
    }
}
