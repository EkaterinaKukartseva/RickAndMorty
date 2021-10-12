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
    
    init(info: InfoModel) {
        self.count = info.count
        self.pages = info.pages
        self.next = info.next
        self.prev = info.prev
    }
}

// MARK: - CharacterListPaginationPresenter
final class CharacterListPaginationPresenter: CharacterListPaginationViewOutputProtocol {

    private let view: CharacterListPaginationViewInputProtocol?
    var interactor: CharacterListPaginationInteractorInputProtocol!
    var router: CharacterListPaginationRouterProtocol!
    
    private var currentPage = 1
    private var info: Info!
    private var isNextPageAvailable = true
    
    required init(view: CharacterListPaginationViewInputProtocol) {
        self.view = view
    }
    
    func showCharacterList() {
        interactor.provideCharacterList(by: currentPage)
    }
    
    func showEpisodeListNextPage() {
        guard isNextPageAvailable else { return }
        view?.setPageLoading(with: true)
        currentPage += 1
        interactor.provideCharacterList(by: currentPage)
    }
    
    func showCharacterDetails(with id: Int) {
        router.openCharacterDetailsModule(with: id)
    }
}

// MARK: - CharacterListPaginationPresenter + CharacterListPaginationInteractorOutputProtocol
extension CharacterListPaginationPresenter: CharacterListPaginationInteractorOutputProtocol {
    
    func receiveCharacterList(_ model: InfoCharacterModel) {
        self.info = Info(info: model.info)
        isNextPageAvailable = info.next != nil
        view?.setCharacterList(model.results.map { .init($0) }, isNextPage: info.prev != nil)
    }
}

// MARK: - Location private
private extension Character {
    
    init(_ model: CharacterModel) {
        self.id = model.id
        self.name = model.name
        self.image = model.image
        self.gender = model.gender
        self.status = model.status
    }
}
