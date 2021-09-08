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
}

// MARK: - CharacterListPresenter + CharacterListViewOutnputProtocol
class CharacterListPresenter: CharacterListViewOutnputProtocol {

    unowned let view: CharacterListViewInputProtocol
    var interactor: CharacterListInteractorInputProtocol!
    var router: CharacterListRouterProtocol!
    
    required init(view: CharacterListViewInputProtocol) {
        self.view = view
    }
    
    func showCharacterList(with ids: [Int]) {
        interactor.provideCharacterList(with: ids)
    }
    
    func showCharacterDetails(with id: Int) {
        router.openCharacterDetails(with: id)
    }
}

// MARK: - CharacterListPresenter + CharacterListInteractorOutputProtocol
extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    
    func receiveCharacterList(_ list: [Character]) {
        view.setCharacterList(list)
    }
}
