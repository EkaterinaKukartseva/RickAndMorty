//
//  CharacterListPresenter.swift
//  RickAndMorty
//
//  Created by EKATERINA  KUKARTSEVA on 08.09.2021.
//

import Foundation

// MARK: - Character
struct Character {
    
    let id: Int
    let name: String
    let image: String
    let status: String
    let gender: String
}

// MARK: - CharacterListPresenter + CharacterListViewOutputProtocol
class CharacterListPresenter: CharacterListViewOutputProtocol {

    private let view: CharacterListViewInputProtocol?
    var interactor: CharacterListInteractorInputProtocol!
    var router: CharacterListRouterProtocol!
    
    required init(view: CharacterListViewInputProtocol) {
        self.view = view
    }
    
    func showCharacterList(with ids: [Int]) {
        interactor.provideCharacterList(with: ids)
    }
    
    func showCharacterDetails(with id: Int) {
        router.openCharacterDetailsModule(with: id)
    }
}

// MARK: - CharacterListPresenter + CharacterListInteractorOutputProtocol
extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    
    func receiveCharacterList(_ list: [CharacterModel]) {
        view?.setCharacterList(list.map { Character(model: $0) })
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
